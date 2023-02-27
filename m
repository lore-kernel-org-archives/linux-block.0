Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11220C64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjB0VT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB0VTU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 16:19:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09473D33C
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 13:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677532735; x=1709068735;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DX80PnHjJHoZBpzLbMSl34pvvXAuVXENmZVvv87jZNg=;
  b=VDVywx8jJTo5pUeJpf2QOe+IJmqiXqutMJyoNqKe9Cr6t+NMFcuwSLM4
   Glk6FO8LfShgnBwtbqrlHHQ7ZggyUvHVoTjsFX1uF3vo+/+wPIO15Urr2
   14bLIPUbAtb3cwpcCwZUZnVPlqqfrWbnkvuvRUdQR50Yxm0G4tdNc6k06
   SyC8yGlemTQvdR+gk+i+jDZF8FdsnwTux9otMHLaMKLekk4QH/MC32yhq
   qvxpEi3x5xdF2+RUcIdx3tI4th0Qgif4vzHD3s+wywdsZ5nT+RHpjv1PN
   L3av+YT9JvWBYv0RqAvBSOukxY1Eif5HACn8cQt9MOT7afVpEtEAVLy9m
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,220,1673884800"; 
   d="scan'208";a="328672284"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 05:18:32 +0800
IronPort-SDR: UM9NCDa6tBI4xGMO9Mglse9xSb/6DxdkZzgCCcreq3+pREizGZegv3BC9Ry1fKKIiVF9Rzcnin
 m+aOnjvJ5EyjkZgS4E8J5hw1w/XoG5krc+vRuH/GXYAn6oWTJHCYaAwFmqwEHeCQJQny+lMxnP
 lPUSkOmSl2vycTLnNMq+2d+e1Fqz1EYZCzOsHYZwhkJtm5nWANDPd/q/Z4Qtx38nGXix+SXJct
 ysFvrQHHvOfolLLUVwaarT3YmdaBZGhSGlGRocVbJIB8zxMA4YGNyaNbp1krIc8hrf1UvMPenY
 YQs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 12:29:39 -0800
IronPort-SDR: oyBpEBFwELdESkZB+KJ5bV2rsa5BXA3f0tfOKGxLqtUm1frZtD0oIf2HJCfqGfxKp4BjKuHFsV
 1dpe485HtU/iBtImvDmZoMYCwCEZOMDF/jKWIoSgnr5NxpgGOE+pjr3VbugZ8zbvlSXF2PblKR
 aQJjqEFqi/SrMCHbbn04w0YtIVc8RrFaQQfQ5Yl2vwrXNQABYwbGk1GB+0bT115N8daP7wl7SS
 RSR+mHsb0ejgviuirJZxE5LFwAmtPjxawB8wyhl+K9bw89IdQLlwMH1vauuAjbzRSVnHUzfM2p
 7FU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 13:18:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PQYJR64HJz1Rwtl
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 13:18:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677532711; x=1680124712; bh=DX80PnHjJHoZBpzLbMSl34pvvXAuVXENmZV
        vv87jZNg=; b=gfDm7UacfGl4S7JY8ppurANZH5fOxlOdeX+COAZW/l1Z+US4tLM
        L8z5JkyoiiJ2Tc3t7UtCy5Fv+UNB13ImMZd+eVkxUpUTaldtgx4qy5xGwXbr0dBM
        AnEqSqwShOU6nEI9f1IFA1rtGmF2wDX6qTlK3M67aLFuzULZEtdJR3Hy2ipke5XA
        JJVfllp+tw0xGxeqHmBRsfMt8xX3jZHyV+7GleotWUMoxlOv9waOPsEeZlL0VjXb
        THgLxAs8PTRAOM+Cuw0fh/Q97PsTvNThgo/RhbBGL69vE2NV26mBpgg8EYAWIp7J
        a/SuTMpWweayZh8elDVl9XmHzE4hiECmr6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MhH7Qn5Bc9ZC for <linux-block@vger.kernel.org>;
        Mon, 27 Feb 2023 13:18:31 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PQYJP3wmLz1RvLy;
        Mon, 27 Feb 2023 13:18:29 -0800 (PST)
Message-ID: <f39d4184-db92-3101-1e83-b0aa65699aa8@opensource.wdc.com>
Date:   Tue, 28 Feb 2023 06:18:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
References: <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
 <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
 <3ea301b1-c808-ce08-8ec8-3a631b385fb9@suse.de>
 <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/23 02:44, Keith Busch wrote:
> On Mon, Feb 27, 2023 at 06:28:41PM +0100, Hannes Reinecke wrote:
>> On 2/27/23 17:33, Sagi Grimberg wrote:
>>>
>>> I'm not up to speed on how CDL is defined, but I'm unclear how CDL at
>>> the queue level would cause the host to open more queues?
> 
> Because each CDL class would need its own submission queue in that scheme. They
> can all share a single completion queue, so this scheme doesn't necassarily
> increase the number of interrupt vectors.

Ah yes. good point. I always forget about the shared completion queue :)

>>> Another question, does CDL have any relationship with NVMe "Time Limited
>>> Error Recovery"? where the host can set a feature for timeout and
>>> indicate if the controller should respect it per command?
>>>
>>> While this is not a full-blown every queue/command has its own timeout,
>>> it could address the original use-case given by Hannes. And it's already
>>> there.
>> I guess that is the NVMe version of CDLs; can you give me a reference for
>> it?
> 
> They're not the same. TLER starts timing after a command experiences a
> recoverable error, where CDL is an end-to-end timing for all commands.

-- 
Damien Le Moal
Western Digital Research

