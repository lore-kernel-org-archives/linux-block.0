Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B368C43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 08:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5386D2089E
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 08:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g5YlHCaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUIsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:48:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35608 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFUIsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 04:48:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so1356827edd.2
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t6tylhnbQpj1jAhFBa0rAUXZzkXjsMfz2Ana0lXAfNo=;
        b=g5YlHCaQAlLDmldSUhxDuKeMbwZmSdbJP0pdBqdPrpFMWSk7NgHLSpYUCCbFImSvLv
         sU9VkypB9692DZ2w3qjFUUf6N8aEyKwznxxI7KCEmeeeN7i0lzx8fwSxZTxdAreMec4M
         UcdMadpgDWCmgAwgad1ZcdAAIzsuVFGP3PptjVlyKyrIbPMJEwbfpOjqaHLnk0hfz+Xu
         +dWweoGYFf/FyWkxB0b66zXxIzO9HzxCpx5MxVq6wMMkxXxTY3KCNzLMV14Yuvy0JK9L
         xzppw9j+ZK1KOEYZaWwB/unBbWK+0DBLmNGN9FEZ1pMyhXP+uWTxMxXSe6Au55r/anyg
         vqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t6tylhnbQpj1jAhFBa0rAUXZzkXjsMfz2Ana0lXAfNo=;
        b=J4zWvPo8Uko6zMwNNSYxb8+9MNXQvwKN5yltH3/1TWhM+HeavKe1Qj759ORKi3a3Zj
         wEmq5vMXWUTBUCVfTFK/Xl3s3wdUPdDUoNI1KYmwLGPXRGkx7K1QKlssQG+NEWXzercA
         /tFjy1UoLemkPYVHH+vgqLzZT5Aqz1KyvaE3WTelb6kPA8/Fisr/2WSM0U1m85xi0/ZV
         u1GQYVOmdb6T1Hrb7mklIulhg2+VT5JZJrt9RgZCV0HAMHJRQGFaAsdhabMB3jkYyLgd
         vlAcBK99xL7SikjuZgoFFbb5f6EbR7JMdFfNpjKYZKveifhD+NHdDZAGtiqdR34+6YM9
         7fJw==
X-Gm-Message-State: APjAAAUm8jENG+ckRGqdeN/eozzG0kr48nSEM74kUlYpnmqmHRa0vYTd
        b9IK+ws8uYBbJ/e4bO/bK0EZ498Ftd7TYwHR
X-Google-Smtp-Source: APXvYqyUkh2RasSYvNJRiNGjFx2DUsNhZL3V6e4Q95Cp5/uZbHJ7uOjwN8WR2atsf+BlT1S0Vevkhw==
X-Received: by 2002:a17:906:2605:: with SMTP id h5mr89106520ejc.178.1561106933830;
        Fri, 21 Jun 2019 01:48:53 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id m6sm638892ede.2.2019.06.21.01.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:48:52 -0700 (PDT)
Subject: Re: [PATCH for-block] cgroup: export css_next_descendant_pre for bfq
To:     Christoph Hellwig <hch@lst.de>, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, linux-block@vger.kernel.org
Cc:     cgroups@vger.kernel.org
References: <20190621082248.11427-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c516717e-fb04-108a-02d4-28ed37140f1b@kernel.dk>
Date:   Fri, 21 Jun 2019 02:48:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621082248.11427-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/19 2:22 AM, Christoph Hellwig wrote:
> The bfq schedule now uses css_next_descendant_pre directly after
> the stats functionality depending on it has been from the core
> blk-cgroup code to bfq.  Export the symbol so that bfq can still
> be build modular.

Applied, thanks.

-- 
Jens Axboe

