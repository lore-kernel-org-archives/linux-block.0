Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12AFC433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 22:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJDWfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJDWfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 18:35:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF1FAFA
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664922899; x=1696458899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G0Cz013hrBxnry1hziTrqbqgGA4zQdvcqYvl1r/wTKk=;
  b=Ao0+20Pulkbj0BA7D73pzYjoQ5LZVaNxBWBy19lE+ADKlMnOs+RRNR49
   7ORiMyk/ZrnEngD3wglwonwpGxl428KIA4X8aadfWxluXHA0GdN1v3vS9
   N7V55z4r8Yr8cKxgHCsgPdHUS2+dKZbPR/BzLd2iIP05pKvd3uHNJ9iOB
   ltVkTrrDKFVsOyy2DQhAicAVVQj9W3fUw6mP3ALPwxZoGH32syFLnInZk
   21kpAxy8oTMPr+gBNemH640dqe7oSjPCgnJ+3BqQF3HNU5GGcpitWHBKE
   Q5u9JUonosjSrqYzSUKIYrO6HnOjS0QpJ41kXIrWUaPTHwRsfKqgLIEOY
   A==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="325094017"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 06:34:58 +0800
IronPort-SDR: 8Mq38fz/8+aYg9CUafJ189hNp+Xgb/nUOAeRdZGSsI5dC0qg7ZfggbPaT7S3pNIZ0aBWLyZ0/M
 GCKC/T5GvPhoDMtnVdGPBFXohcgaCinBT34N08t1Pi4TmTKw+NGgqIriOPQ8FmSie+G7LFwA00
 gv1HXZuPzMYUUnSoN1HIgzZO9UCayoh9wwx/FmFeXNeeMc/uhk5jrYB7IMRz52vesvJkGahK0H
 i59nS+H4ksH8liEv2UslXbD7KZY40apZZLn1KijfXDbUPMjf+tgNmByMG9BChMzXdRLyD7xT4+
 G4P/bzibzTu5hPGtVrgh2580
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 14:54:46 -0700
IronPort-SDR: YpRUEqjmjg9ywHnja/KLtWz8eG61lRAhkX6Zx6K95r6QMBKJoqq6Isjrd2iudMDDhlWfg9EYs9
 EgPW2JpiljHl9f0AgphTxXYG3LsryNRwED9mzn/v4NKkQ+8tpug2E4whlpy70a/c9Mz/Nfw8aI
 Q6BWdWFm7l7M5nhx9n/QTVuPLiNVlAeCjB0zk4rxaEgwR1Y1M+QiTMkZgiEOA5vZxeRIF9fIrH
 EVkeI4rSvtsJmB+b9EuOpfeZAXlsnGtf2yjkWoeLa8nYv0+/6n2NHFI0IXsHXt55zDaXEpuyT5
 NRc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:34:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mhsw21mX3z1RvTr
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 15:34:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664922897; x=1667514898; bh=G0Cz013hrBxnry1hziTrqbqgGA4zQdvcqYv
        l1r/wTKk=; b=CNMOBY4wN7t1et/jHuKKGopfWerwof3RTute05VtJ4XJTDyqA7R
        xXxuRaQ57E78lXrW+KL7r4B1LfxKj99FP32hXFh/dzoAfobLgUZTDT0IVGPeXOMF
        hx3wHV4Okwpm1T78sXNAwXFhiuXaxuTH6VUXy1V263zlmv3hbFLk7jCzAFAqY6sa
        Nu8RObJcv3KkTuQ1fotwrpVC7ir2UhV0KHN+uYIsqVPLGgO223+8QI1DJ6PyQY1K
        1ijT79KgoaH9OCWnThCpc4YUwq8PX05CTMCpaF3MEo49qYcScpCRITwb4FDb7g+D
        zd6M2wkNXt8zXtdPXO4ImFwuGPQrRBGYxJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v9HQ-F7pcvNC for <linux-block@vger.kernel.org>;
        Tue,  4 Oct 2022 15:34:57 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mhsw02ysnz1RvLy;
        Tue,  4 Oct 2022 15:34:56 -0700 (PDT)
Message-ID: <d9d9ae2f-dea1-4672-8458-c2542c1f951f@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 07:34:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: lockdep WARNING at blktests block/011
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221004104456.ik42oxynyujsu5vb@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/22 19:44, Shinichiro Kawasaki wrote:
> On Oct 03, 2022 / 09:28, Keith Busch wrote:
>> On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
>>>
>>> BTW, I came up to another question during code read. I found nvme_reset_work()
>>> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
>>> controller is already disabled when the reset work calls nvme_sync_queues().
>>
>> Right, everything previously outstanding has been reclaimed, and the queues are
>> quiesced at this point. There's nothing for timeout work to wait for, and the
>> sync is just ensuring every timeout work has returned.
> 
> Thank you Keith, good to know that we do not need to worry about the deadlock
> scenario with nvme_reset_work() :)  I also checked nvme_reset_prepare() and
> nvme_suspend(). They also call nvme_dev_disable() or nvme_start/wait_freeze()
> before nvme_sync_queues(). So I think the queues are quiesced in these context
> also, and do not worry them either.
> 
>>
>> It looks like a timeout is required in order to hit this reported deadlock, but
>> the driver ensures there's nothing to timeout prior to syncing the queues. I
>> don't think lockdep could reasonably know that, though.
> 
> I see... From blktests point of view, I would like to suppress the lockdep splat
> which triggers the block/011 failure. I created a quick patch using
> lockdep_off() and lockdep_on() which skips lockdep check for the read lock in
> nvme_sync_io_queues() [1] and confirmed it avoids the lockdep splat. I think
> this lockdep check relax is fine because nvme_sync_io_queues() callers do call
> nvme_dev_disable(), nvme_start/wait_freeze() or nvme_stop_queues(). The queues
> are quiesced at nvme_sync_io_queues() and the deadlock scenario does not happen.
> 
> Any comment on this patch will be appreciated. If this action approach is ok,
> I'll post as a formal patch for review.
> 
> [1]
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 66446f1e06c..9d091327a88 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5121,10 +5121,14 @@ void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
>  {
>         struct nvme_ns *ns;
> 

I think there should be a comment here explaining why your turn off lockdep.

> +       lockdep_off();
>         down_read(&ctrl->namespaces_rwsem);
> +       lockdep_on();
>         list_for_each_entry(ns, &ctrl->namespaces, list)
>                 blk_sync_queue(ns->queue);
> +       lockdep_off();
>         up_read(&ctrl->namespaces_rwsem);
> +       lockdep_on();
>  }
>  EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
> 

-- 
Damien Le Moal
Western Digital Research

