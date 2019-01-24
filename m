Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E473C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C688221872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yxnmJ27+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfAXSML (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:12:11 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:33237 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAXSML (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 13:12:11 -0500
Received: by mail-it1-f182.google.com with SMTP id m8so3089191itk.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xuJe7KYa+CGW6PCICnc5mH9LERIiWudXdK7aF3l4W+Y=;
        b=yxnmJ27+4+2MmYTO85amOWxfgrgWvdeP1xcS90mZJniq+KeMrocjwDsZ5duvg9Jcxm
         QlpDjPAFThnDTlrAXdYCvBKp3wkfHHOY6IdZ4n06xK5lWXYHoumrcOOlN8k4gxKyQMdo
         dPYX9CYl7nQsnVFQYAF0mGQjFZ5+BwNtHcoFOJKWO6FOoc1TwYLEo2AkrUpCv7N+3uW/
         3nYIiz+DzfwlFixHjNU5jSNNRCMpudkgLiXITmpDND0HXQG1KxaAV2fBWAJtmH/mr4M9
         MxGxc4mf+CHwQVhTZqx0hk1pfP4gE3KQiOilEk51HjCs8vq4qL07/bPJtvSwwzjkCWC2
         4Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuJe7KYa+CGW6PCICnc5mH9LERIiWudXdK7aF3l4W+Y=;
        b=qORM9GVhQhfdx1LSmrp2uZxrpClyfcMweXuiBHGj/1Pcr/0GD13Nbq46PIzRQKbuQv
         yYW4ibJPUOurphdDbbV5Hb9SxUptWpRgKR08GzRL3P1zvoyanYNBWhN8guxEVSgcFhdp
         +BZThyQYEHkdGSTKEjUZT425uIxmTp3LTsk1whaDbFrKc2LsEyJvO3GYQyLFPAfdC+oQ
         1QVDfKtHjFXiD/IYEJmiPo6YjWTqxqa6v62VNo0U6+miYKbXZGedsrM5IPJHMq9VMAy/
         zgi4Y5E+ekWCoO51b5VF2TcPH4ElB1ENAVGDVU5PdS47v/t7HPSe+d8H4/EyzivBC8PM
         w33w==
X-Gm-Message-State: AJcUukfnyNKowmvRZ8etCNy/GYDhR62FCN+UUcn6C6XpU7ZM5kDqjOHx
        JUnivtifya3zTJBs7UCgCy0T9gOqTmY=
X-Google-Smtp-Source: ALg8bN4wC0MwO0TVxZ4NnLLiKPGXFPHrAVz+TJl3GTrwfVI2c0OABOQdbk5ceSzvOd7zGAHAdQof2w==
X-Received: by 2002:a24:10cb:: with SMTP id 194mr428509ity.173.1548353529731;
        Thu, 24 Jan 2019 10:12:09 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u126sm11275445ita.1.2019.01.24.10.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:12:08 -0800 (PST)
Subject: Re: [PATCH] block: Fix comment typo
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20190124092014.28656-1-damien.lemoal@wdc.com>
 <20190124092014.28656-2-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <926bcf9f-e508-b4eb-4ae5-d29bde102f2d@kernel.dk>
Date:   Thu, 24 Jan 2019 11:12:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124092014.28656-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 2:20 AM, Damien Le Moal wrote:
> Fix typo in REQ_OP_ZONE_RESET description.

Applied, thanks.

-- 
Jens Axboe

