Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8270C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B902133F
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfFYP4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:56:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36080 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYP4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 11:56:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so9085025plt.3;
        Tue, 25 Jun 2019 08:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X8PyZ6mm09HvpAjBsN2bzxK8nd8cfLA+VCOhqGU8yjE=;
        b=I5N7UWptXauuBXj0zCCEqNUP6Ikcvnh0iUfEdHUe9jMdkFcxlT+nI2FFF/9d3LfmlE
         5KD1XFPShCo6Nht+1WjDMfGYv+TrBU4jyEa2mQ2W0om0iL+AcQSpTZasjMKCcoV0VpGw
         ixao1WARIi0zXaeqiKgan6dAvCL6Tb6PAbboSzerx6n5NJU5l384Zf8dJvORmE7q9hvE
         Zz3P9gEkZWK5jpCReQx7JWMT2pEUTU1pCKJuby0CTm3zmPngK6LQTDKHlvxoSZnZku62
         LGrZP60u7GgFaXAia9hICu3UEEMmgHUwjDk3ktpIZDN6kpW3wO4ONonAbcbi9MtlhMkM
         uKig==
X-Gm-Message-State: APjAAAVsLAKAArFUE7xVSOwdWZ1rqY0D9CMQqu56xEM356Dff/r6MYpD
        lQHZ6fvquh8fhqfGFQauCBY=
X-Google-Smtp-Source: APXvYqzqnMz19/tkZ2lWR1LALGAy9toe5Xj906/48mLtj3J82ryMK3ntCRQMy81JplrGUfNQYwrwTg==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr72155467pln.304.1561478159207;
        Tue, 25 Jun 2019 08:55:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 5sm14545676pfh.109.2019.06.25.08.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:55:58 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
 <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org>
 <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
 <cce08df0-0b4d-833d-64ce-f9b81f7ad7ca@lightnvm.io>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <79ca395d-8019-9ec8-0c0b-194ca6d9eda0@acm.org>
Date:   Tue, 25 Jun 2019 08:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <cce08df0-0b4d-833d-64ce-f9b81f7ad7ca@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/19 3:35 AM, Matias Bjørling wrote:
> On 6/25/19 12:27 AM, Chaitanya Kulkarni wrote:
>> On 6/24/19 12:43 PM, Bart Van Assche wrote:
>>> static inline bool op_is_write(unsigned int op)
>>> {
>>>     return (op & 1);
>>> }
>>>
>>
> 
> The zone mgmt commands are neither write nor reads commands. I guess, 
> one could characterize them as write commands, but they don't write any 
> data, they update a state of a zone on a drive. One should keep it as 
> is? and make sure the zone mgmt commands don't get categorized as either 
> read/write.

Since the open, close and finish operations support modifying zone data 
I propose to characterize these as write commands. How about the 
following additional changes:
- Make bio_check_ro() refuse open/close/flush/reset zone operations for 
read-only partitions (see also commit a32e236eb93e ("Partially revert 
"block: fail op_is_write() requests to read-only partitions"") # v4.18).
- In submit_bio(), change op_is_write(bio_op(bio)) ? "WRITE" : "READ" 
into something that uses blk_op_str().
- Add open/close/flush zone support be added in blk_partition_remap().

Thanks,

Bart.
