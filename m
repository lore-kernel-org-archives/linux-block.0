Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6353AC32771
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 01:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIVBtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiIVBtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 21:49:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF9EA2602
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:49:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so659473pja.5
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EdofFh1zJYKxWaotCjEobUwjoe51ZOFIi1QQMBQcpdw=;
        b=hl5GoDbs6iV3ErjeWEV4kDw1opBdjF5cN7GW1BQyMtf85bHT1b0IrfTQG7PvSiEZ/t
         F1EHStEVm4ppK2ypuawj92ymnnEVF353BBFs5FYAEjD+dVRJSqZEWJsawFI1KW1KyB0Z
         wuK/HU4HAyX9y8UlVX5lsJlc/gOspH01igst4EQxOa49uVLQaH34fmW920pHQaq7VjND
         P8pxVM1JExbDuLO2TrPDs+WCrbGOBbtR1ngLOkYL4jKyC4JATMMDtJzQKttQmVDODJRo
         CbZlhtg1vphkI3K0okIMHyAntBKd8mHn06WfHi2p7yWBxIscCmjjxsjxw+kKxemFh6DU
         q+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EdofFh1zJYKxWaotCjEobUwjoe51ZOFIi1QQMBQcpdw=;
        b=yIkNZaQFK7dvpUga80FjAQJ4Or7SZs6WPm+WSd8dK0qXGW/maA8dzDP1GZKASOM2iM
         bh49d3pQ7PGZtnvNgg3yBa2aZjooEaO0WHZ8wqLpk0you0u9LEPYiO0fdfhs486XX6fT
         KheDtp5ctjZLJS7haF7fVVKUVpssgBYCHxT6bUYBz5ugzqOec39dO6frHkZW+Jx06IIp
         NBT3aVF6n+n9JCiNEeLkL/Y5jXEkVUXbf3QxP1ZU2d/lsCGgOxw4WAPCRGQJrfUm1qvp
         Jhm7hxXogecbRIVX5Gh1UrqzTfFa+AHSAiBFZVr7r+aaRfLAZeWi3ShInFusANIMWFNC
         q8Ow==
X-Gm-Message-State: ACrzQf10skAvLyp1WrLz/ny7qp8EsFLqZRLqWCQaDGVuvhH6cCT6v2EH
        KjFHQ69p3r48GthCi9KwCEpalw==
X-Google-Smtp-Source: AMsMyM6sWsyX2iQm5MMGsy98UlgEocNBge4B8rj8aB/HjhL8TP71gCQcNl+TJxxi3sTGJJNrLkpRtA==
X-Received: by 2002:a17:902:c104:b0:176:e2fa:2154 with SMTP id 4-20020a170902c10400b00176e2fa2154mr1030343pli.98.1663811357852;
        Wed, 21 Sep 2022 18:49:17 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k7-20020aa79727000000b005484d133127sm2839472pfg.129.2022.09.21.18.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 18:49:17 -0700 (PDT)
Message-ID: <78adb638-d78d-b0a3-0d3a-69dcaa32bb6e@kernel.dk>
Date:   Wed, 21 Sep 2022 19:49:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] block: aoe: use DEFINE_SHOW_ATTRIBUTE to simplify
 aoe_debugfs
To:     Christoph Hellwig <hch@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
References: <20220915023424.3198940-1-liushixin2@huawei.com>
 <Yyluvun0JFf7Mai1@infradead.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yyluvun0JFf7Mai1@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/22 1:41 AM, Christoph Hellwig wrote:
> How maintained is aoe still?  Everytime I looked at it it feels
> more and more bitrotting..

It's not maintained at all.

-- 
Jens Axboe


