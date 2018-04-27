Return-Path: <sbauer@plzdonthack.me>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Scott Bauer <scott.bauer@intel.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org
References: <20180426175108.29280-1-scott.bauer@intel.com>
 <20180427124114.pjaajoljcyr5h3jc@mwanda>
From: Scott Bauer <sbauer@plzdonthack.me>
Message-ID: <c2bdace5-f513-476a-59b0-4062ffb5416e@plzdonthack.me>
Date: Fri, 27 Apr 2018 08:43:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180427124114.pjaajoljcyr5h3jc@mwanda>
Content-Type: multipart/alternative;
 boundary="------------83CF4F8C549439D12BCEF72E"
Subject: Re: [PATCH] cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------83CF4F8C549439D12BCEF72E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 04/27/2018 06:41 AM, Dan Carpenter wrote:
> I sent you an email to send this patch, but reviewing it now it's not
> actually a run time bug.  The cdrom_slot_status() function takes an
> integer argument so it works.

It's still  runtime bug... I should reword the commit a bit to reflect that it's not
like the upper 32 bit issue that you had found. Look at it this way, ints can be negative, right?

The check is as follows:

2545:	if (((int)arg >= cdi->capacity))
		return -EINVAL <https://elixir.bootlin.com/linux/v4.17-rc2/ident/EINVAL>;
	return cdrom_slot_status <https://elixir.bootlin.com/linux/v4.17-rc2/ident/cdrom_slot_status>(cdi, arg); so if (-65536 >= cdi->capacity) it's not so we don't return -einval. And we pass a negative index into cdrom_slot_status.


where we do the following (https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/cdrom/cdrom.c#L1336):

1336:
	if (info->slots <https://elixir.bootlin.com/linux/v4.17-rc2/ident/slots>[slot <https://elixir.bootlin.com/linux/v4.17-rc2/ident/slot>].disc_present)
		ret = CDS_DISC_OK <https://elixir.bootlin.com/linux/v4.17-rc2/ident/CDS_DISC_OK>;



>
> I'm working on a static checker warning for these kinds of bugs:
>
> drivers/cdrom/cdrom.c:2444 cdrom_ioctl_select_disc() warn: truncated comparison 'arg' 'u64max' to 's32max'
>
> drivers/cdrom/cdrom.c
>   2435  static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
>   2436                  unsigned long arg)
>   2437  {
>   2438          cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n");
>   2439  
>   2440          if (!CDROM_CAN(CDC_SELECT_DISC))
>   2441                  return -ENOSYS;
>   2442  
>   2443          if (arg != CDSL_CURRENT && arg != CDSL_NONE) {
>   2444                  if ((int)arg >= cdi->capacity)
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^
>   2445                          return -EINVAL;
>   2446          }
>   2447  
>   2448          /*
>   2449           * ->select_disc is a hook to allow a driver-specific way of
>   2450           * seleting disc.  However, since there is no equivalent hook for
>   2451           * cdrom_slot_status this may not actually be useful...
>   2452           */
>   2453          if (cdi->ops->select_disc)
>   2454                  return cdi->ops->select_disc(cdi, arg);
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ->select_disc() also take an int so it's fine (plus there is no such
> function so it's dead code).
>
>   2455  
>   2456          cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
>   2457          return cdrom_select_disc(cdi, arg);
>                                               ^^^
> Also an int.
>
>   2458  }
>
> So I think it's a good idea to fix these just for cleanliness and to
> silence the static checker warnings but it doesn't affect runtime.

Yeah, this one was "fine" aside from being messy, that's why I didn't send a patch for it.

P.S. Is your static analysis tooling available for the general public to look at?

--------------83CF4F8C549439D12BCEF72E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 04/27/2018 06:41 AM, Dan Carpenter
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180427124114.pjaajoljcyr5h3jc@mwanda">
      <pre wrap="">I sent you an email to send this patch, but reviewing it now it's not
actually a run time bug.  The cdrom_slot_status() function takes an
integer argument so it works.</pre>
    </blockquote>
    <br>
    <tt>It's still  runtime bug... I should reword the commit a bit to
      reflect that it's not<br>
      like the upper 32 bit issue that you had found. Look at it this
      way, ints can be negative, right? <br>
      <br>
      The check is as follows:<br>
    </tt><tt><br>
    </tt>
    <pre>2545:	<span class="k">if</span> <span class="p">(((</span><span class="kt">int</span><span class="p">)</span><span class="n">arg</span> <span class="o">&gt;=</span> <span class="n">cdi</span><span class="o">-&gt;</span><span class="n">capacity</span><span class="p">))</span>
		<span class="k">return</span> <span class="o">-</span><span class="n"><a href="https://elixir.bootlin.com/linux/v4.17-rc2/ident/EINVAL">EINVAL</a></span><span class="p">;</span>
	<span class="k">return</span> <span class="n"><a href="https://elixir.bootlin.com/linux/v4.17-rc2/ident/cdrom_slot_status">cdrom_slot_status</a></span><span class="p">(</span><span class="n">cdi</span><span class="p">,</span> <span class="n">arg</span><span class="p">);

so </span><tt>if (-65536 &gt;= cdi-&gt;capacity) it's not so we don't return -einval. And we pass a negative index into
cdrom_slot_status.
</tt></pre>
    <br>
    <pre>where we do the following (<a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/cdrom/cdrom.c#L1336">https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/cdrom/cdrom.c#L1336</a>):

1336:
	<span class="k">if</span> <span class="p">(</span><span class="n">info</span><span class="o">-&gt;</span><span class="n"><a href="https://elixir.bootlin.com/linux/v4.17-rc2/ident/slots">slots</a></span><span class="p">[</span><span class="n"><a href="https://elixir.bootlin.com/linux/v4.17-rc2/ident/slot">slot</a></span><span class="p">].</span><span class="n">disc_present</span><span class="p">)</span>
		<span class="n">ret</span> <span class="o">=</span> <span class="n"><a href="https://elixir.bootlin.com/linux/v4.17-rc2/ident/CDS_DISC_OK">CDS_DISC_OK</a></span><span class="p">;</span></pre>
    <br>
    <br>
    <blockquote type="cite"
      cite="mid:20180427124114.pjaajoljcyr5h3jc@mwanda">
      <pre wrap="">

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
  2443          if (arg != CDSL_CURRENT &amp;&amp; arg != CDSL_NONE) {
  2444                  if ((int)arg &gt;= cdi-&gt;capacity)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^
  2445                          return -EINVAL;
  2446          }
  2447  
  2448          /*
  2449           * -&gt;select_disc is a hook to allow a driver-specific way of
  2450           * seleting disc.  However, since there is no equivalent hook for
  2451           * cdrom_slot_status this may not actually be useful...
  2452           */
  2453          if (cdi-&gt;ops-&gt;select_disc)
  2454                  return cdi-&gt;ops-&gt;select_disc(cdi, arg);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-&gt;select_disc() also take an int so it's fine (plus there is no such
function so it's dead code).

  2455  
  2456          cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
  2457          return cdrom_select_disc(cdi, arg);
                                              ^^^
Also an int.

  2458  }

So I think it's a good idea to fix these just for cleanliness and to
silence the static checker warnings but it doesn't affect runtime.</pre>
    </blockquote>
    <br>
    <tt>Yeah, this one was "fine" aside from being messy, that's why I
      didn't send a patch for it.<br>
      <br>
      P.S. Is your static analysis tooling available for the general
      public to look at?<br>
    </tt>
  </body>
</html>

--------------83CF4F8C549439D12BCEF72E--
