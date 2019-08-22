Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C4C3A5A1
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 13:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B78D21726
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 13:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hHryW5A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHVNPF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:15:05 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:32773 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfHVNPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 09:15:05 -0400
Received: by mail-io1-f45.google.com with SMTP id z3so11774260iog.0
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2019 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wACQbnjh0aNA4U62YRfff3ZMthp3/UCxZOHU2UTFdV8=;
        b=hHryW5A5R1gWDgWah3Hd1cJcQyhNgZOo2l7AblMeRZ857YcqWZ9mTX0R8pvZeseDZy
         zVVAUBhhth70bxfHQUsbElpuY/Lp9NGs0TvLqhchjkdUsDu9LaXYEhBvu5BWqbg+dffM
         ITRmmhpwImhieVN+2KjBDJZMzOIwyiJY/VZWraumnkPVCNEcK4qm5jBIh5RJ01Q+N0hM
         CVZVFRNlTnDp6PxK51xtCO2a72+Vty9bgqWt+2WXgxMWmXKizR8LpGXRIa+rL8lJezA+
         SLW1X+ReXN/qerDb/HClmNrsdGHEC99HEey/kriy3bvIG6W/aNniun6FO+86zW0Kv/Lz
         jqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wACQbnjh0aNA4U62YRfff3ZMthp3/UCxZOHU2UTFdV8=;
        b=Emz7piQM1rycJ3W5f9vt4jsM9USsbI5Wu9cbMriQk3xR5XUuL3lGOCydFPo7VtE+bd
         x7ec8H218rFsFELR0JErnJxSfjbZVIWKCSPTX5Bmn1WItjXkbUnuiYH2BWLVIbFoYXJX
         m5zIIFOHzkjS+IRh+3zbpyKD7AXRpB+gTzM143uAsIhhTkrDx0JwspY6Cr5LIPT0nlAM
         D6qV4gtze04L51WxNTau4ayvBs8XG4Cq54xsvmHsAnaovX56yfMKgtlQzvsDy6a+YCoT
         IhOZulDa1jduajZO22Xo6buKsgOw7Vf7zXIvarknUR41kMEi5GlOVU4HTpEOCQaC1xRH
         Ew/A==
X-Gm-Message-State: APjAAAXHLB02uk8CvFyiSJCcUCUOJDt8eNeospQeruh4jN82n7onrYSa
        xdudh2iZKb7152FIJSKMHnFqUaXshuqgtg==
X-Google-Smtp-Source: APXvYqylIA2f0rn/rW9eth0nXljtBPP5+p9sQOGzsZ3aSg9r8vTiCM9JCoKzQWjhBkUdLma9F5+RIw==
X-Received: by 2002:a6b:a12:: with SMTP id z18mr30131041ioi.222.1566479703525;
        Thu, 22 Aug 2019 06:15:03 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q8sm20276646ion.82.2019.08.22.06.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:15:02 -0700 (PDT)
Subject: Re: bio_add_pc_page cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190812153958.29560-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <44ec0fd2-658e-923c-4850-dfb77a956fea@kernel.dk>
Date:   Thu, 22 Aug 2019 07:15:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812153958.29560-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/19 9:39 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the bio_add_pc_page code and reuses more code
> from the regular bio path.

LGTM, applied for 5.4, thanks.

-- 
Jens Axboe

