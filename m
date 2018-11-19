Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF5C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64322086A
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64322086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeKTJuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:50:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42727 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKTJuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 04:50:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so14546oiw.9;
        Mon, 19 Nov 2018 15:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WoXrwEnmpK86n4njwFaziTaVd4ljc5hniaYuPajmosQ=;
        b=ujQXnQqYfMdTQyteKuSBx7StKFkLvLStDA93/n78gKBRn9LGmXeKMaPbrMf7KE+vlY
         Z+BdigFO9IFA7FEi7O8n8EiQ+frxSNUESJXvcaU50ikkjiV+nDhuwVhG7EW57pIGCSog
         yICHTtUIcof7UvhXwOlxAKz0AZpr2LvvHFqmLIbM1fV4WM0YUyQxVeHm7M420BDlIAdk
         11NqJnyQHu99sb4kIGf0lyrEXORTaobfez/dPabX0KCQ2iAqvEpi875bhgdkcFJaRn2E
         IpHhSYf2poUjyMO2LlFC+piuxC/JXS2NQmwC/WerApJfdSh+Oz66+ft07W/adeL7lGZH
         MmzQ==
X-Gm-Message-State: AGRZ1gLK+Wyy2/D7nsVvAblvYGOFIQuffJV+AjRllZBdMDG2Wdn4p/C7
        /cy//FweE5Omky6I4ti4qpU=
X-Google-Smtp-Source: AJdET5eugH51KVGMy+0+7uDdpkxRHJlLgLXkKvNeNoLTkqEzQ51DcSfT1gFQg0WeFS60keCY/QCm0Q==
X-Received: by 2002:aca:bbc1:: with SMTP id l184-v6mr7900623oif.66.1542669855485;
        Mon, 19 Nov 2018 15:24:15 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v41sm18363784otf.19.2018.11.19.15.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 15:24:14 -0800 (PST)
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
To:     David Miller <davem@davemloft.net>
Cc:     sagi@lightbitslabs.com, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, keith.busch@intel.com, hch@lst.de,
        linux-nvme@lists.infradead.org
References: <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
 <20181119.145343.2254073323355763213.davem@davemloft.net>
 <f4997fa5-a0f1-2783-4732-15fbd7fcafd8@grimberg.me>
 <20181119.151805.2250212740843808194.davem@davemloft.net>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0de07d6d-ed90-df0e-5710-1f5cdddd6187@grimberg.me>
Date:   Mon, 19 Nov 2018 15:24:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119.151805.2250212740843808194.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Also, looking a bit closer there is a slight difference between the
>> copy vs. the copy_and_csum variants. copy allows for a short_copy if
>> we copy less than we expect while the csum faults it. I'm thinking
>> that the copy_and_hash variant should also fault? Although I'm not
>> sure I understand the fault entirely as csum is supposed to be
>> cumulative, any insight?
> 
> When we are writing and signal an error, sockets have this recurring
> pattern where we return immediately the amount of bytes successfully
> transferred.  Then on the next sendmsg() call we give the error.
> 
> I don't know if that is what is influencing the behavior here or not
> but it could be.

That makes sense... Does recvmsg() have the same semantics? this is the
rx path where we copy fragments to an iter..

If so, I guess that it makes sense that we fault and not allow short
copies as we have an incomplete csum in this case...

I'm wandering how we can consolidate the code paths together with this
subtle difference? Perhaps a short_copy flag?
