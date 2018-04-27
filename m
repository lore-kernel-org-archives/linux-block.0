Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 27 Apr 2018 15:41:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        Scott Bauer <sbauer@plzdonthack.me>, stable@vger.kernel.org
Subject: Re: [PATCH] cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
Message-ID: <20180427124114.pjaajoljcyr5h3jc@mwanda>
References: <20180426175108.29280-1-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180426175108.29280-1-scott.bauer@intel.com>
List-ID: <linux-block@vger.kernel.org>

I sent you an email to send this patch, but reviewing it now it's not
actually a run time bug.  The cdrom_slot_status() function takes an
integer argument so it works.

I'm working on a static checker warning for these kinds of bugs:

drivers/cdrom/cdrom.c:2444 cdrom_ioctl_select_disc() warn: truncated comparison 'arg' 'u64max' to 's32max'

drivers/cdrom/cdrom.c
  2435  static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
  2436                  unsigned long arg)
  2437  {
  2438          cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n");
  2439  
  2440          if (!CDROM_CAN(CDC_SELECT_DISC))
  2441                  return -ENOSYS;
  2442  
  2443          if (arg != CDSL_CURRENT && arg != CDSL_NONE) {
  2444                  if ((int)arg >= cdi->capacity)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^
  2445                          return -EINVAL;
  2446          }
  2447  
  2448          /*
  2449           * ->select_disc is a hook to allow a driver-specific way of
  2450           * seleting disc.  However, since there is no equivalent hook for
  2451           * cdrom_slot_status this may not actually be useful...
  2452           */
  2453          if (cdi->ops->select_disc)
  2454                  return cdi->ops->select_disc(cdi, arg);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
->select_disc() also take an int so it's fine (plus there is no such
function so it's dead code).

  2455  
  2456          cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
  2457          return cdrom_select_disc(cdi, arg);
                                              ^^^
Also an int.

  2458  }

So I think it's a good idea to fix these just for cleanliness and to
silence the static checker warnings but it doesn't affect runtime.

regards,
dan carpenter
