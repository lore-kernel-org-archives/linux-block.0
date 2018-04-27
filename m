Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 27 Apr 2018 18:13:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Scott Bauer <sbauer@plzdonthack.me>
Cc: Scott Bauer <scott.bauer@intel.com>, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
Message-ID: <20180427151336.3u6x5z44ajansrbt@mwanda>
References: <20180426175108.29280-1-scott.bauer@intel.com>
 <20180427124114.pjaajoljcyr5h3jc@mwanda>
 <c2bdace5-f513-476a-59b0-4062ffb5416e@plzdonthack.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <c2bdace5-f513-476a-59b0-4062ffb5416e@plzdonthack.me>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 27, 2018 at 08:43:03AM -0600, Scott Bauer wrote:
> 
> 
> On 04/27/2018 06:41 AM, Dan Carpenter wrote:
> > I sent you an email to send this patch, but reviewing it now it's not
> > actually a run time bug.  The cdrom_slot_status() function takes an
> > integer argument so it works.
> 
> It's still� runtime bug... I should reword the commit a bit to reflect that it's not
> like the upper 32 bit issue that you had found. Look at it this way, ints can be negative, right?
>

Oh.  Yeah.  Duh...

> The check is as follows:
> 
> 2545:	if (((int)arg >= cdi->capacity))
> 		return -EINVAL <https://elixir.bootlin.com/linux/v4.17-rc2/ident/EINVAL>;
> 	return cdrom_slot_status <https://elixir.bootlin.com/linux/v4.17-rc2/ident/cdrom_slot_status>(cdi, arg); so if (-65536 >= cdi->capacity) it's not so we don't return -einval. And we pass a negative index into cdrom_slot_status.
> 
> 
> where we do the following (https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/cdrom/cdrom.c#L1336):
> 
> 1336:
> 	if (info->slots <https://elixir.bootlin.com/linux/v4.17-rc2/ident/slots>[slot <https://elixir.bootlin.com/linux/v4.17-rc2/ident/slot>].disc_present)
> 		ret = CDS_DISC_OK <https://elixir.bootlin.com/linux/v4.17-rc2/ident/CDS_DISC_OK>;
> 
> 
> 
> >
> > I'm working on a static checker warning for these kinds of bugs:
> >
> > drivers/cdrom/cdrom.c:2444 cdrom_ioctl_select_disc() warn: truncated comparison 'arg' 'u64max' to 's32max'
> >
> > drivers/cdrom/cdrom.c
> >   2435  static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
> >   2436                  unsigned long arg)
> >   2437  {
> >   2438          cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n");
> >   2439  
> >   2440          if (!CDROM_CAN(CDC_SELECT_DISC))
> >   2441                  return -ENOSYS;
> >   2442  
> >   2443          if (arg != CDSL_CURRENT && arg != CDSL_NONE) {
> >   2444                  if ((int)arg >= cdi->capacity)
> >                             ^^^^^^^^^^^^^^^^^^^^^^^^^
> >   2445                          return -EINVAL;
> >   2446          }
> >   2447  
> >   2448          /*
> >   2449           * ->select_disc is a hook to allow a driver-specific way of
> >   2450           * seleting disc.  However, since there is no equivalent hook for
> >   2451           * cdrom_slot_status this may not actually be useful...
> >   2452           */
> >   2453          if (cdi->ops->select_disc)
> >   2454                  return cdi->ops->select_disc(cdi, arg);
> >                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > ->select_disc() also take an int so it's fine (plus there is no such
> > function so it's dead code).
> >
> >   2455  
> >   2456          cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
> >   2457          return cdrom_select_disc(cdi, arg);
> >                                               ^^^
> > Also an int.
> >
> >   2458  }
> >
> > So I think it's a good idea to fix these just for cleanliness and to
> > silence the static checker warnings but it doesn't affect runtime.
> 
> Yeah, this one was "fine" aside from being messy, that's why I didn't send a patch for it.
> 

I'm not convinced any more.  Could you patch it and resend?  We could
end up sending invalid commands to the cdrom firmware when we do
cdrom_load_unload() at the end of the cdrom_select_disc() function.
Proably there is no impact but we may as well fix it.  Here is my
analysis if you are curious:

  1371  /* If SLOT < 0, unload the current slot.  Otherwise, try to load SLOT. */
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
CDSL_CURRENT is INT_MAX and CDSL_NONE is "INT_MAX - 1" but
cdrom_select_disc() calls this with slot set to -1.

  1372  static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot) 
  1373  {
  1374          struct packet_command cgc;
  1375  
  1376          cd_dbg(CD_CHANGER, "entering cdrom_load_unload()\n");
  1377          if (cdi->sanyo_slot && slot < 0)
  1378                  return 0;
  1379  
  1380          init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
  1381          cgc.cmd[0] = GPCMD_LOAD_UNLOAD;
  1382          cgc.cmd[4] = 2 + (slot >= 0);
                ^^^^^^^^^^
So cmd[4] is 2.

  1383          cgc.cmd[8] = slot;
                ^^^^^^^^^^^^^^^^^
Here were setting cmd[8] to any u8 value we choose.

  1384          cgc.timeout = 60 * HZ;
  1385  
  1386          /* The Sanyo 3 CD changer uses byte 7 of the 
  1387          GPCMD_TEST_UNIT_READY to command to switch CDs instead of
  1388          using the GPCMD_LOAD_UNLOAD opcode. */
  1389          if (cdi->sanyo_slot && -1 < slot) {
  1390                  cgc.cmd[0] = GPCMD_TEST_UNIT_READY;
  1391                  cgc.cmd[7] = slot;
  1392                  cgc.cmd[4] = cgc.cmd[8] = 0;
  1393                  cdi->sanyo_slot = slot ? slot : 3;
  1394          }
  1395  
  1396          return cdi->ops->generic_packet(cdi, &cgc);
  1397  }

> P.S. Is your static analysis tooling available for the general public to look at?

Sure.  I've been dorking with it for a couple days and I haven't tested
the latest version except on drivers/cdrom/cdrom.c so let me do some
more testing and then I'll post it.

regards,
dan carpenter
