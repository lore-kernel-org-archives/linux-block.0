Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB00CDB482
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 01:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjJQBON (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjJQBOM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 21:14:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7CAB
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 18:14:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca79b731f1so3275225ad.0
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697505251; x=1698110051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyE+eoJiyBmwqe0k2aZhgcAkQ0mUJ7owsxJAxWWwCGk=;
        b=ga2upFcXutWu8hWLE3UIYhPn+/0AE8kIvVpT2+jkDaRwEMnp1rP0mj1jGEoIVH0177
         qT+Piph4/vO2NJ6De83iaY/ZojcKOztZAYGdxT+yLFhiZC9ZCJ5S0pp/eV/z73V1ahlm
         4nQ/IMy43U70kVAZJN/0DQrpbys3heI0KX+2zIGG+6KtuLL94Cz5Nrwlfodj/siPSxOK
         On2QGCRm9zbwe2nAigxDWU+TL3gkaHgzhY+srIlRNLNiWgUZxXTbu5HHBqMUVAgcOCMo
         iKn6800dtsUp2vx2OzckTZp7Ti1wcJ+co7QlpwhFvfjloILA+/ppVI++jcjrLv/SsI2R
         /mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697505251; x=1698110051;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyE+eoJiyBmwqe0k2aZhgcAkQ0mUJ7owsxJAxWWwCGk=;
        b=MWRyuTEvobi4sxp7gmo1BQI/E1ZoJUtWai9/MAHBy7tlHlMXg7LOloz+nDfE48KpZm
         f6SQy4S6lyHgU8ew9QjWO83O1pIBG92oYxni1rTNgC3cjumf98L+Kotqjrjl2pYl89QE
         zcysJ7jhVTC5EEcIMeDn6TtKxFb9aSjWt0j4tVhyV+Hejsl31CzjngQ639NmAPigM1x9
         LquUwGSijRz1RgxZAi4C0N5nsPkvvlfC82y+h2E+kwqtxp8z1VDLS4carw3U+dIVgiWk
         yEAGfW8upyekEZQYob0NN9tWsIN99K42U2XZu2yq7kNDT0qRnFrrC/b00sK6VY2oWMMr
         UMqQ==
X-Gm-Message-State: AOJu0YxpsqOV6KyzopwwBRzetlVbxyLiur0roTFK07TpQavs0fIH8QKg
        4OsFE8nhnILmBklwfqsGughbww==
X-Google-Smtp-Source: AGHT+IHMSMs4TeTY9CgnmHF2uwIh5w8bCOdYO5OpGzaF1GowsNIpq3iD0dtck5RNFS5Ee6zfDxE0Zg==
X-Received: by 2002:a17:902:bd07:b0:1ca:28f3:569a with SMTP id p7-20020a170902bd0700b001ca28f3569amr877708pls.5.1697505250769;
        Mon, 16 Oct 2023 18:14:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b001c5fa48b9a0sm231465pld.33.2023.10.16.18.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 18:14:10 -0700 (PDT)
Message-ID: <be05643a-b75f-44c8-9dc2-35a914a51397@kernel.dk>
Date:   Mon, 16 Oct 2023 19:14:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.7/io_uring 0/7] ublk: simplify abort with cancelable
 uring_cmd
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20231009093324.957829-1-ming.lei@redhat.com>
 <ZS3LhEInXtaO+O1y@fedora>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZS3LhEInXtaO+O1y@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/23 5:47 PM, Ming Lei wrote:
> On Mon, Oct 09, 2023 at 05:33:15PM +0800, Ming Lei wrote:
>> Hello,
>>
>> Simplify ublk request & io command aborting handling with the new added
>> cancelable uring_cmd. With this change, the aborting logic becomes
>> simpler and more reliable, and it becomes easy to add new feature, such
>> as relaxing queue/ublk daemon association.
>>
>> Pass `blktests ublk` test, and pass lockdep when running `./check ublk`
>> of blktests.
> 
> Hello Guys,
> 
> Ping...

I thought I had already queued this up... Done so now, thanks Ming.

-- 
Jens Axboe


