Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CF6C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449CE20767
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405820AbgFXSd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:33:28 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:42175 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405581AbgFXSd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 14:33:28 -0400
Received: by mail-pg1-f174.google.com with SMTP id e9so1800350pgo.9
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 11:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRoXAY61ujBuGuGuDtY/xGH0xaEBTGmp3dkdcOa0oGw=;
        b=QJC5qH7Q2z8Rw5GJwQH9y1Ztqec3mVPMyqXjDbM5jCWbpFNlYeHG2/Dh6xYSxa/Zzc
         noiliFIOMGlXKEsWDdaALCaASyi3XKvrdE6jWMuw4h7cE9HkYQk2JvLOqaY0wd58BLN9
         HpyiOD37ee4JODy+WqyZffpihyh30wek4BVFcDO+x6JR2lkv2r4cuPG7qXq6CHsfxydV
         UUALajzcaIGKleBNquAecnOQAi8uF/nSpWRMi4MvNYOzyEW4+4tsE5Q7H+mQO2lu8/xl
         DDVXuQR1cASO9fPvmimsX4LUoHNiKRaMK+n7SrrURUbcpyOwRITJBq35bc66lAhzW73p
         aQNw==
X-Gm-Message-State: AOAM530CiR7eSimdoJUzJ3fvM2uQmSxyhjOTYsJyyr0SV2JUQNXhYPF1
        Ybt8dHFVohm6F6XzudMoGO4=
X-Google-Smtp-Source: ABdhPJxM+gFoDorwA7Sr7XSBQYVD7Fvy03hdubcRm4eOP8XYB4IhoVY0datfR8mBpxJfmL6bNwlLSw==
X-Received: by 2002:a63:df01:: with SMTP id u1mr20849152pgg.401.1593023607699;
        Wed, 24 Jun 2020 11:33:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947? ([2601:647:4802:9070:4c08:474f:e61d:6947])
        by smtp.gmail.com with ESMTPSA id r77sm3162884pfc.87.2020.06.24.11.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:33:27 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
Message-ID: <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
Date:   Wed, 24 Jun 2020 11:33:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> If the controller does not support the CNS value, it may return Invalid
>> Field with DNR set. That error currently gets propogated back to
>> nvme_init_ns_head(), which then abandons the namespace. Just as the code
>> coments say, we had been historically been clearing such errors because
>> we have other ways to identify the namespace, but now we're not clearing
>> that error.
> 
> I don't understand what you are saying Keith.
> 
> My comment was for this block:
> -- 
>      if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>          dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
>               nsid);
>          status = -EINVAL;
>      }
> -- 
> 
> I was saying that !status doesn't necessarily mean success, but it can
> also mean that its an retry-able error status (due to transport or
> controller). If we see a retry-able error we should still clear the
> status so we don't abandon the namespace.
> 
> This for example would achieve that:

Sorry, meant this:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba512c45b40f..3187cf768d08 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1130,8 +1130,14 @@ static int nvme_identify_ns_descs(struct 
nvme_ctrl *ctrl, unsigned nsid,
                   * Don't treat an error as fatal, as we potentially 
already
                   * have a NGUID or EUI-64.
                   */
-               if (status > 0 && !(status & NVME_SC_DNR))
+               if (status > 0 && !(status & NVME_SC_DNR)) {
                         status = 0;
+               } else if (status == 0 && nvme_multi_css(ctrl) && 
!csi_seen) {
+                               dev_warn(ctrl->device,
+                                       "Command set not reported for 
nsid:%d\n",
+                                       nsid);
+                               status = -EINVAL;
+               }
                 goto free_data;
         }
--
