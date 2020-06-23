Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 23:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3526A20888
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 23:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgFWXRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:17:36 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:54416 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbgFWXRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 19:17:35 -0400
Received: by mail-pj1-f54.google.com with SMTP id u8so168455pje.4
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 16:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8v36kYHXqDYrXPPTKD7e7zSjDj1Y3K52NiTT8vrQFZs=;
        b=FG/PMmQhE8p2RJMEvqduOUo45UyDON0A9UsQWJS6Kh8xPNzTGvkDKifSITmBcCWcuH
         WCLlM50AiMoxr6mocsVwTtpF6pDX4z5xk0iNs82zWtcikiRIXZSbJBUl/8Urb6y8xd89
         fMxSQPOO3DsaHFqr/NAFLTCV8JfudjOnsfnO3V5N3heDLPStMjVHip8vxUuh2sii6f2y
         DHTn2Ci0ATVWlClOWXsQH3j/G076j5gvyv2c2adRNcNRH1As/g9UrlW3uDAec6mM4JR4
         Cn16/cSf8UsYm9199F20L2dybT6D/LJtoqkjmJLirHflJ4FCoqa+hXzvUUB/FU5VBb5m
         8z4w==
X-Gm-Message-State: AOAM533SDmg74ufAqUUwnw9cWPpK8QqAKht7HiMud0iQ2z+TT6Jg78NX
        319da0tBGmwOOj+Vq5otNbiBH7pr
X-Google-Smtp-Source: ABdhPJyxl4r8T7DEPzVPz2DLf7o7GMcybweLGUVOHBnXcHDft4F8gcBM7tpnsMQdahNy5CwdmTqzdg==
X-Received: by 2002:a17:90b:fd3:: with SMTP id gd19mr3695656pjb.83.1592954253341;
        Tue, 23 Jun 2020 16:17:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b? ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
        by smtp.gmail.com with ESMTPSA id c194sm17615949pfc.212.2020.06.23.16.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 16:17:32 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Keith Busch <kbusch@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
Date:   Tue, 23 Jun 2020 16:17:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> -		len = nvme_process_ns_desc(ctrl, ids, cur);
>>>> +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
>>>>    		if (len < 0)
>>>>    			goto free_data;
>>>>    		len += sizeof(*cur);
>>>>    	}
>>>>    free_data:
>>>> +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>>>
>>> We will clear the status if we detect a path error, that is to
>>> avoid needlessly removing the ns for path failures, so you should
>>> check at the goto site.
>>
>> The problem is that this check has to be done after checking all the ns descs,
>> so this check to be done as the final thing, at least after processing all the
>> ns descs. No matter if nvme_process_ns_desc() returned an error, or if
>> simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
>> end without error.
>>
>> Even if the nvme command failed and the status was cleared:
>>
>>                  if (status > 0 && !(status & NVME_SC_DNR))
>>                          status = 0;
> 
> This check is so weird. What has DNR got to do with whether or not we
> want to continue with this namespace? The commit that adds this says
> it's to check for a host failed IO, but a controller can just as validly
> set DNR in its error status, in which case we'd still want clear the
> status.

The reason is that if this error is not a DNR error, it means that we
should retry and succeed, we don't want to remove the namespace.

The problem that this solves is the fact that we have various error
recovery conditions (interconnect issues, failures, resets) and the
async works are designed to continue to run, issue I/O and fail. The
scan work, will revalidate namespaces and remove them if it fails to
do so, which is inherently wrong if these are simply inaccessible by
the host at this time.
