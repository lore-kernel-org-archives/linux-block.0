Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFBFC432C3
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 16:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107A720721
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sm8z1kAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfKSQXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:23:53 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35976 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfKSQXx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Nov 2019 11:23:53 -0500
Received: by mail-io1-f67.google.com with SMTP id s3so23889922ioe.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2019 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xBPbB0l5zXDQJ0ykS2pcsoh3Vk0x6ZjZkqP5G3hnUM=;
        b=Sm8z1kApGq1YRmDHN+gWoe8jgDmvwDTCFFbiUOE1ZzL8UwxD3CHaIoj+U5vroJWotn
         Scut8GZMnc8ZVRAlIPwAPkDombOWJhIA00gLfMjNYwogATUHyj0IBnX8faNEHJg5o8ca
         gObf0a+uUbqjo+e6kg0rH3OXqyinmg1Rg8+uGrYDl2GhtmuOFwEm8YpOIyPpKPvfrFpb
         lIkft9nZX3+00p4t4ppCCYYsyrmw5CGl6t1i6z2UeK2K79X1yq33aKR0DkCeaKTCXlNS
         TceACMWTRkXkyzpznWBS38sjIeR0hM6kullpYZnPiDZ/0omJbyifVdCf7/AeK4ILPBdj
         meGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xBPbB0l5zXDQJ0ykS2pcsoh3Vk0x6ZjZkqP5G3hnUM=;
        b=nrav1nwN37Wu9fQVsOawT0WlSsLIgiN4FGcPfvKdPaKv4HiaPViB2IuUEB3Rk0i1a7
         m2jerWvy0ijL3aSP4+T+/C/QzTxP/xa1r/8JiGI6oUS6LdpBhZNXfj0gvH3oFsQ/C72D
         KZdAeSrvpah0meurAmEFljS2OmmgKAZt9p95VZ2bIjQfeRw9SC7w8Rs97T2RX4I3FWLa
         aU78wpxp5SsCTZdPRo7WaX1NkGXu6i4XgF056+v4J5SqhUwQN3hyoK2t5ET2qApH+Umq
         vgnTDGKGfJ9SGIdsIstvaaquBf9ZXTS2vpfvw8R8gAYYCh8Mu54rgf1/kfOk+fPKVCFC
         tTgQ==
X-Gm-Message-State: APjAAAVoGo9h8kWGQx+enJObN5vqKTATfV31/kQNqNuuXFHDDbJOtz6j
        25Chfv3J0JKEUbwJVTyWMKdKeg==
X-Google-Smtp-Source: APXvYqz/gjRUdkRFVh4ufDotsnWFDqpbvx2ZHAFudSc3izo4sM/ESTDEoM2N3Z6rLIWo+SHS9cyzig==
X-Received: by 2002:a02:40c6:: with SMTP id n189mr430847jaa.18.1574180632196;
        Tue, 19 Nov 2019 08:23:52 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y8sm5611174ilg.47.2019.11.19.08.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:23:51 -0800 (PST)
Subject: Re: [v2] nbd:fix memory leak in nbd_get_socket()
To:     Mike Christie <mchristi@redhat.com>, Sun Ke <sunke32@huawei.com>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <1574143751-138680-1-git-send-email-sunke32@huawei.com>
 <5DD416DB.1040302@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7d5d08c-c8d6-cd22-ba0a-e53ab08ea5d8@kernel.dk>
Date:   Tue, 19 Nov 2019 09:23:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5DD416DB.1040302@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/19 9:22 AM, Mike Christie wrote:
> On 11/19/2019 12:09 AM, Sun Ke wrote:
>> Before return NULL,put the sock first.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> v2: add cc:stable tag
>> ---
>>   drivers/block/nbd.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index a94ee45..19e7599 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -993,6 +993,7 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>>   	if (sock->ops->shutdown == sock_no_shutdown) {
>>   		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
>>   		*err = -EINVAL;
>> +		sockfd_put(sock);
>>   		return NULL;
>>   	}
>>   
>>
> 
> Reviewed-by: Mike Christie <mchristi@redhat.com>

Thanks (both of you), applied for 5.4.

-- 
Jens Axboe

