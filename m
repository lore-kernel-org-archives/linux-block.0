Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72CC5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 01:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjAJBsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 20:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjAJBsG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 20:48:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C5CDF95
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 17:48:05 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so7203338pga.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 17:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13PNfeDQX5uKa4zPuQWn14poKVG6C+eNy5nJkulJa+4=;
        b=CAuqLXAxw223OEPcIXj0iysNuoC2kv3JLiMMyFBtQDv/ZgCX6yEnujGjvWMp5lodzj
         XHyaIrDxo6w7xkt4U50CfNN7nWv0aBukgpzuOMBRqGyACEHLPC0bhXhkSRsmA8064W5w
         JIpJLr5Rm8q0j6V2dm60Nra7a5AAbK1JV/SfDkSh4j0HZa6zBtmQ0gGOxbzp6toBbHZJ
         GuDRSyq38pREz8gFNMoWaKGF/yWgo4XgV4h+ckFihGaJNDH/NGVizUYH8010KLj+5o7I
         zdiXRtGzg6v9MuX6wMV5921xWZyvDaCr2Tk6aFW5nGwWsfHDOIYcOCiiAwfxwocnpu/l
         VWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13PNfeDQX5uKa4zPuQWn14poKVG6C+eNy5nJkulJa+4=;
        b=7EcTY13/guJs81veurB65yrdZsf7mtThVKSDFl6zqZ23zIAZNzMcpyqoTwhjLMdzJT
         RZE6+Dq/nA338rZQBpSueJoaT4MIaG/VXnpjvcZF0adG93wufLf5TsQQswh6y/VL8JZ4
         2lReNzWBNfCwKFxy6RBJZJFTk7iV7N7Y0jLhEn3KQsvAbNNOABVkeSkfHH8ZJK8zWMe1
         89Hx9QdhgtXkRJTeCDQDsryvfLzZEXpGcSqE91uTK++ESzOLiKp2maqEv4x8Z7A/gq5L
         RNIBuBD2Dp9Rl2H0XNVuYoMUpyPM/3RdVSUdqQV1F7sZ4NmHPbL5/ooeJYEFdyCyCOYk
         TRDQ==
X-Gm-Message-State: AFqh2kpnvhj+8O1DcqIv/hQXdosjeKurFmeFqcvR8ZyxCE5j+TYZ53dD
        X0tqwkFhOc/ppTIRMd2hHNhAHw==
X-Google-Smtp-Source: AMrXdXvqo/DZnnIppwciFcQktaxLYcVrFKZWlLYwoo5ckthNdx2vABfjl5qBcKABk/tjiUMOXNyl+Q==
X-Received: by 2002:a62:58c7:0:b0:577:3e5c:85e5 with SMTP id m190-20020a6258c7000000b005773e5c85e5mr15240757pfb.0.1673315285086;
        Mon, 09 Jan 2023 17:48:05 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 130-20020a621788000000b00587fda4a260sm3344779pfx.9.2023.01.09.17.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 17:48:04 -0800 (PST)
Message-ID: <8f653339-cd1a-5078-d34f-7b6951baf64a@kernel.dk>
Date:   Mon, 9 Jan 2023 18:48:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
 <07084f70-00a7-d142-479c-52c75af28246@acm.org>
 <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
 <31d32f69-4c14-c9be-494f-7071112073f9@acm.org>
 <86eef990-0725-9669-6b7e-1fe935a6b648@kernel.dk>
 <f47f32d8-92a3-b7d5-a462-d34da9263d34@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f47f32d8-92a3-b7d5-a462-d34da9263d34@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 6:17?PM, Bart Van Assche wrote:
> On 1/9/23 17:03, Jens Axboe wrote:
>> Because I'm really not thrilled to see the addition of various "is this
>> device ordered" all over the place, and now we are getting "is this
>> device ordered AND pipelined". Do you see what I mean? It's making
>> things _worse_, not better, and we really should be making it better
>> rather than pile more stuff on top of it.
> 
> Hi Jens,
> 
> I agree with you that the additional complexity is unfortunate.
> 
> For most zoned storage use cases a queue depth above one is not an
> option if the zoned device expects zoned write commands in LBA order.
> ATA controllers do not support preserving the command order.
> Transports like NVMeOF do not support preserving the command order
> either. UFS is an exception. The only use case supported by the UFS
> specification is a 1:1 connection between UFS controller and UFS
> device with a link with a low BER between controller and device. UFS
> controllers must preserve the command order per command queue. I think
> this context is well suited for pipelining zoned write commands.

But it should not matter, if the scheduler handles it, and requeues are
ordered correctly. If the queue depth isn't known at init time, surely
we'd get a retry condition on submitting a request if it can't accept
another one. That'd trigger a retry, and the retry should be the first
one submitted when the device can accept another one.

Any setup that handles queue depth > 1 will do just fine at 1 as well.

-- 
Jens Axboe

