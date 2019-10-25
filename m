Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1642CCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C5021872
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KiPkWWdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfJYUMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:12:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45830 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJYUMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:12:39 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so3787758iot.12
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q2Wefv4p05Rw5GUqJ1dU96PFo3cHwrjtOnlb8nlo4Ns=;
        b=KiPkWWdqQ+RMi+EcsOWt59M8422RMo8p2UaC5qGbeGInizhrr+GNXf9uY49XICRcLi
         8JFAtzL313+g472HZb8E/o1W8Jm7eqwYusbd+2jAMJxFU9KxfOtctzDx8LJLAXDG1w+Z
         LAT9FLotafI7agLIPjVZ34uQisxYopULXyTeUOMmDNoJswgzcHz2OWKl/7k+DnYiykfO
         huo5bz2Cd4/DzLPUgooXLqJ/vwcJxuwRzdhWJ5CAshGF+XHxdftLUJcnlluAbnqsSqy8
         DLzbpNHt0FJSPubtycV/TdohuXW8xnb+YDspt5tSW4vWp10SZq/twcg0ZIX7XUxS3yYG
         SjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q2Wefv4p05Rw5GUqJ1dU96PFo3cHwrjtOnlb8nlo4Ns=;
        b=p2SapJjMldU2EtsLb9gNEgmWJfDC02ADHmWwo86qUwIq/wDYm/BPGEeWBi8I+k+206
         73wzDKy/DksGZSTkIT8+Sl9AGgZ1uE1aHtecT0kKzneN96N6g2Nu2O8Led3WkC78nkpu
         fIjhMvE1vnoB0VW8vGv4oMnq/f8Kbqjkmkb4Rilip+4OTiDTakj4lWujTByRl7dF9JHz
         h0QddDEBs68MaNfdJjmLfyC2LyRviyXtveX89JjrXDuupZcAwtpYhtDZIS6RRElg2Ysz
         5zOvbOl6a6BpZwn6Oloz/CbxIi6N/psHfgF01N2I2328+Ju2uf5fpGYZQRf9kyLEj1R0
         FFYQ==
X-Gm-Message-State: APjAAAUJ5cKn4Q0Z91TsFbfDyDYIRcYxBZpD9UWihbyYQnwLb5rAVEpK
        x+gmfefHMSxert71c/mgwnoGGSjoAXAD1A==
X-Google-Smtp-Source: APXvYqwkELyt1r/AnGtHRkOMqTKZkVjUKiKJdsDxYlW5e+dlLY6PnqyQnI2wVeET4BgW9lKR/R0/vQ==
X-Received: by 2002:a6b:7609:: with SMTP id g9mr5927054iom.130.1572034358184;
        Fri, 25 Oct 2019 13:12:38 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d21sm357174iom.29.2019.10.25.13.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:12:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Reduce the amount of memory required for request
 queues
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20191025165010.211462-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e515b561-5339-654f-419c-7f3b490a6abc@kernel.dk>
Date:   Fri, 25 Oct 2019 14:12:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025165010.211462-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 10:50 AM, Bart Van Assche wrote:
> Hi Jens,
> 
> This patch series reduces the amount of memory required for request queues
> and also includes a patche that is the result of reviewing code related
> to the modified code. Please consider these patches for kernel version v5.5.

Applied, thanks Bart.

-- 
Jens Axboe

