Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB8C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhLMSnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbhLMSnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 13:43:04 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF3C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:43:04 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z26so19602594iod.10
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qV363Uzs/wKJ/6cHzZG00O38gNwsVyW3JyGuzl1dnYQ=;
        b=vhl/ilHZICZ+GBX9JtaiW4XwgABor/6HplEg5Wq4Lq9xIC1gr3xQ4XRbqSb1XzEF3k
         Uv9+8YT+TOroVMOVlkVleG/CrZkcqoVsMukWobDWIOQ1nbiMoLO7TPxfBCZR4Jdy8Onn
         ZTOb+zREzwveqETI3DAIIkxSckSCzEpx82PhZqfhi/BSGSM6fJ34g6tVp1xkaAwk45U+
         KpLywUquq+Gw+FmVA9HDCkg8HLsldBn+4/HjyOYOhAJG8nF8ORWmSr7f78seCp+FqFvJ
         gqAW7U42/k9j13Zv3RM43eG/4tyPTGnj288O4f/rQ0GhJn7ZUPkGN+IH4a4fl4eGa95/
         AtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qV363Uzs/wKJ/6cHzZG00O38gNwsVyW3JyGuzl1dnYQ=;
        b=c3uB7Z3fMTIeFswHYMdppP2jqYVhZA7nR2xWTwXMAwXQkxdr2PHQo4GER+nGwv12dW
         UFmSeoh4JoHkcq9Cbd49k8h+JMCJBGPx8Ow+DBu25GmujLTJnvnQzevgW60ET+8ghYqP
         yeG9Qb6H8WbSaL8rQf+9FwnCoJyuMZg4TaXHZVEFh8D6kuSCofK9AklmX/WW6JNNnW0A
         Uxlc2PABYU+V7uvMG1iVCWqZQJRoLeAQ2pp7y1rfVVoA/iw6y4AcU6BU8TMzJ8uk9DM9
         heUy/+bPRplMfopVgABAWp9yNJW0ugduPFdY9C3ftiGjP8rcdpizk5U41rfDPge5apRZ
         qb9Q==
X-Gm-Message-State: AOAM530k66oB8LX3jaRE92Hct09PbXI6iloVEYtuM17JoQErjVtGTjLN
        5FDW1aFbu1/9OhLsQIi+/BcFqg==
X-Google-Smtp-Source: ABdhPJzGU1XYgcN4u/Bt6j5VVaZX9Ds2Vxz5HGjVIF/UszvjMut7NqICgyCqqIq7awb7yfqc768Y0A==
X-Received: by 2002:a05:6602:2d51:: with SMTP id d17mr365470iow.47.1639420983479;
        Mon, 13 Dec 2021 10:43:03 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-2faa6b4db27sm8004173.305.2021.12.13.10.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:43:03 -0800 (PST)
Subject: Re: Random high CPU utilization in blk-mq with the none scheduler
To:     Dexuan Cui <decui@microsoft.com>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <c5c8f95e-f430-6655-bab5-d2a2948ab81d@kernel.dk>
 <BYAPR21MB127011609EBF6567126EBF83BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270B53CFDDFD52AD942B3AEBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b4350274-7219-1d1f-7a39-3f445c081fd1@kernel.dk>
 <BYAPR21MB1270C642C3200EC4E65C586EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb696622-38ee-c582-ce70-5bfa632f8989@kernel.dk>
Date:   Mon, 13 Dec 2021 11:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1270C642C3200EC4E65C586EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/21 11:54 AM, Dexuan Cui wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>> Sent: Saturday, December 11, 2021 6:21 AM
>>
>> Sorry, can you do:
>>
>> # perf report -g --no-children
>>
>> instead?
> 
> Attached.

I wonder if this will help, SCSI artifact making us hit the
mod delayed work path all the time. Might be a race in there,
but should be fine for testing.


diff --git a/block/blk-core.c b/block/blk-core.c
index 4d8f5fe91588..cb2f4d604bad 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1625,7 +1625,9 @@ EXPORT_SYMBOL(kblockd_schedule_work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 				unsigned long delay)
 {
-	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	if (!work_pending(&dwork->work))
+		return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	return true;
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 

-- 
Jens Axboe

