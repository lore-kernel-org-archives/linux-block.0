Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942A0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 00:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiFWAZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 20:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWAZC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 20:25:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E46657C
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655943901; x=1687479901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZTTaCheu8ellCvhM6bLnO/JawA7IoQyRLHNHgXG8wnw=;
  b=Pkq5SUkiCRjCL4GilIKsXKa7Svf3pCWMwzD67nvkPPsa+vhi2j5LVVZM
   s/U/9jRLO2dCbaKYOYC+7oQkrIgPmmH6DDFplxrLzEmaULBZLt/nDU2KL
   oTmkXTN59Vh3JOPPMWg75a52GvaOKP5XSfeU2WRvt+7vlEgFr01xCBLFf
   urMBoF8NQbdFqTIkxCkRvlKla4bJzNsW9MiTxd9bgY4+T6/NXOuOaec2q
   okxXmKtGBPi/rrpBKIvKJxCLcw23hmMEaSQXZxT6lo6arM2wx3fjNWx3x
   PQjmFheKk9eqgLIbgixf7Krh7vQIM0ABzyZ7TKlSlVR6nDSw9q3pMRilB
   w==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="204623676"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 08:25:00 +0800
IronPort-SDR: f+3Nnm+KN+mmo3PQVb4UDSQV0j+7alzO4UdRuy2U8qxLx6A4kbaYpd8XIUmQ8xT1yewiRQVm9d
 75GIMgvl0jpRfTtW485oq8aGAWT3eIM7FWHzkde5FdwzIebuYp9lBTEDP29YTdCkqm0tjAvVdl
 9ujmAozmgF9UVe6Db8kcGQk2UgIf8zrZSOROBGK+u8YB0bCWfUn+VBLWi43MqC9E2qeJiSqUxP
 JxETBWNuEpcmlwyhCOHUCYZid/APlNVsbD2YcXtvJnBOfUmG/ojoNoHewyjA+IHEeENYJBuLev
 hgDDn238d0mUSMnx/qZ/aLYl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2022 16:42:47 -0700
IronPort-SDR: evdHlciUnu2vtT2grvKKZBsPQ1nU8NwxFze2tNiNrrQA4xDdH7dEgxJcE+zI3ta234/XPXT+pc
 RgnnGkZ9v5qyNc252/fwt3HD8sEp57N5cKnhbvyETzje2Ptluwn6XJuDuE8/c9gx+QeTepHO37
 RtGPPYP6W09tpf4qDqFw29JJerkVPCdQYfgNstuE82ZblXteDsmQdeU/lmqhgch2b/nJ0uOszB
 Dv73X51L8eZy06eHsN6hSPVSo/cgTcwC9kmBthU7mTh9FsWhUbSNIojIWBAbq+hSXe1SWDFZ0X
 LLE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2022 17:25:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LT1Gz6KTSz1Rwnl
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 17:24:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655943899; x=1658535900; bh=ZTTaCheu8ellCvhM6bLnO/JawA7IoQyRLHN
        HgXG8wnw=; b=FK9Zzl32zpMyRxeeUWxKVNXbDlOYfuZotQbJHUKBR22WxdF6qHx
        zXz2xFqPbDyO4Nm7FuK1oxk+HZFP1VDq+DwoHgSoRv26U0FwTs3Ys6LYT9CXtHWW
        pTmEIHba+PspD+yb1KipuWwm1VeHRm52Z7zK7GOSuf3HVKlufJr3i0hYmxB3Y1x+
        eNsa6Nh5VurLFnk40Yv+p4hg4XGgyw4kMPDa+y1ITg7LUQn0VqKE2JJsDncbmKvw
        6xBxkehL8lTVvlq0Uy5MdVV/z0zAKH5SkHZ32/CYUPM3JTkywyGFxyHPIyySKH65
        WOcZ8Tiy4Ag9vfaS3vBN+z752GxwIflxv+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5Qi62h22JVSl for <linux-block@vger.kernel.org>;
        Wed, 22 Jun 2022 17:24:59 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LT1Gy0jGPz1RtVk;
        Wed, 22 Jun 2022 17:24:57 -0700 (PDT)
Message-ID: <217a12c7-fd02-1e3d-16cc-207e7c55551b@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 09:24:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/9 v4] block: Fix IO priority mess
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220621102201.26337-1-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 19:24, Jan Kara wrote:
> Hello,
> 
> This is the fourth revision of my patches fixing IO priority handling in the
> block layer.

Hey,

I ran some tests with RT IO class on an ATA HDD with NCQ priority.
Results look good:

randread: (groupid=0, jobs=1): err= 0: pid=1862: Thu Jun 23 09:22:42 2022
  read: IOPS=152, BW=19.1MiB/s (20.0MB/s)(11.1GiB/592929msec)
    slat (usec): min=37, max=3280, avg=174.96, stdev=120.90
    clat (msec): min=7, max=918, avg=156.95, stdev=149.43
     lat (msec): min=7, max=918, avg=157.13, stdev=149.43
    clat prio 0/0 (msec): min=7, max=918, avg=171.68, stdev=150.48
    clat prio 1/0 (msec): min=8, max=166, avg=24.64, stdev= 5.93
    clat percentiles (msec):
     |  1.00th=[   15],  5.00th=[   20], 10.00th=[   23], 20.00th=[   32],
     | 30.00th=[   51], 40.00th=[   77], 50.00th=[  108], 60.00th=[  146],
     | 70.00th=[  194], 80.00th=[  262], 90.00th=[  372], 95.00th=[  477],
     | 99.00th=[  659], 99.50th=[  701], 99.90th=[  793], 99.95th=[  818],
     | 99.99th=[  885]
    clat prio 0/0 (89.99% of IOs) percentiles (msec):
     |  1.00th=[   15],  5.00th=[   21], 10.00th=[   27], 20.00th=[   46],
     | 30.00th=[   68], 40.00th=[   94], 50.00th=[  126], 60.00th=[  163],
     | 70.00th=[  213], 80.00th=[  279], 90.00th=[  388], 95.00th=[  489],
     | 99.00th=[  659], 99.50th=[  709], 99.90th=[  793], 99.95th=[  827],
     | 99.99th=[  885]
    clat prio 1/0 (10.01% of IOs) percentiles (msec):
     |  1.00th=[   14],  5.00th=[   17], 10.00th=[   18], 20.00th=[   20],
     | 30.00th=[   22], 40.00th=[   23], 50.00th=[   25], 60.00th=[   26],
     | 70.00th=[   28], 80.00th=[   30], 90.00th=[   33], 95.00th=[   35],
     | 99.00th=[   40], 99.50th=[   42], 99.90th=[   47], 99.95th=[   50],
     | 99.99th=[  167]

Clearly significantly lower tail latencies for the 10% of IOs with class
RT (1/0), as expected. This is with "none" scheduler at QD=24 (128K random
read).

Feel free to add:

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> Changes since v3:
> * Added Reviewed-by tags from Damien
> * Fixed build failure without CONFIG_BLOCK
> * Separated refactoring of get_current_ioprio() into a separate patch
> 
> Changes since v2:
> * added some comments to better explain things
> * changed handling of ioprio_get(2)
> * a few small tweaks based on Damien's feedback
> 
> Original cover letter:
> Recently, I've been looking into 10% regression reported by our performance
> measurement infrastructure in reaim benchmark that was bisected down to
> 5a9d041ba2f6 ("block: move io_context creation into where it's needed"). This
> didn't really make much sense and it took me a while to understand this but the
> culprit is actually in even older commit e70344c05995 ("block: fix default IO
> priority handling") and 5a9d041ba2f6 just made the breakage visible.
> Essentially the problem was that after these commits some IO was queued with IO
> priority class IOPRIO_CLASS_BE while other IO was queued with IOPRIO_CLASS_NONE
> and as a result they could not be merged together resulting in performance
> regression. I think what commit e70344c05995 ("block: fix default IO priority
> handling") did is actually broken not only because of this performance
> regression but because of other reasons as well (see changelog of patch 3/8 for
> details). Besides this problem, there are multiple other inconsistencies in the
> IO priority handling throughout the block stack we have identified when
> discussing this with Damien Le Moal. So this patch set aims at fixing all these
> various issues.
> 
> Note that there are a few choices I've made I'm not 100% sold on. In particular
> the conversion of blk-ioprio from rqos is somewhat disputable since it now
> incurs a cost similar to blk-throttle in the bio submission fast path (need to
> load bio->bi_blkg->pd[ioprio_policy.plid]).  If people think the removed
> boilerplate code is not worth the cost, I can certainly go via the "additional
> rqos hook" path.
> 
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20220601132347.13543-1-jack@suse.cz # v1
> Link: http://lore.kernel.org/r/20220615160437.5478-1-jack@suse.cz # v2
> Link: http://lore.kernel.org/r/20220620160726.19798-1-jack@suse.cz # v3


-- 
Damien Le Moal
Western Digital Research
