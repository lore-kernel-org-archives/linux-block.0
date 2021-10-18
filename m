Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5E3C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB11860F93
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhJROjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhJROjK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:39:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B5C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 07:36:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h196so16551682iof.2
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYQ40MId6dNd5t6vHxiFIXgJLS+wvGo/3qnwQCAoaRQ=;
        b=oja/XpFRk6X7cCHMjhRo3r34IdokgoJR0Sr00xw3F6Zyh8/1t6HnOAnSsfuHEomEAI
         lVAJDAZraH29YWiFDefdwDXkFR/CExswzJSe3ikBrlcaND78qjXCOZGApf7xW+PZAg8m
         3+UdN5xgJdkdnD8/fbTujghbgP7v3KB7KmHSTGKl3jo/ODocxI96hfFC3IFFwC4EHlXe
         zPqO69/OfZ6FdUgSA2BmXQUxhBcUECayXaZtYtS5qxCIR6GVEGU84FjmWzfpN7/3twJR
         vcQuf6cM1rPtcM2tazGQ6/KsaFkFn2/tSHQZd9QAPWyAKfzzFgj/5b+MDL0klmOWEpO6
         wyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYQ40MId6dNd5t6vHxiFIXgJLS+wvGo/3qnwQCAoaRQ=;
        b=wbEh772NuRnYVKb8OvRt1vEfrFcdhRphwQCof8vDRZvHjU4sktO1wwhGS0DJvUAfzV
         su8seWFz03vLaV+YUIgkWqsAQBoyp30ZdNg/uChN7P3dhkPh9v4sNwp/4LsFzOuuy++a
         7/2KV7WyFG55tvM6TPjTRSuCIbfTy+oVkydN9F/dxerDSB02zeeZBtFqUJMQV1k1iS+D
         FeXW0lvvL2Bj+1dcJnsGMJlFWgLrTX77S5SqqejPQR5+imFtbncGYSlJH39JCYi4YwRw
         965xpVoD3A234uWnA2loUHqsuYXcbniH5i5FhJT98r7Cyv/2QqFlShHhGBOOjrVIDLxp
         Mz3A==
X-Gm-Message-State: AOAM531qU4zGFOIZuGuYqBtDeuzObyRG1kZ8MhgkVq6XLVDvmT3qT6qp
        f26eRSG5GL9y/iibtOvhxWR/SiAdL4yfiw==
X-Google-Smtp-Source: ABdhPJzlY2nORlarn5LpG8yUp1QfkN0BpUiEQBcaW8PicbzLR78k7fJizeVJYafOlqYfK4KtMB7vjQ==
X-Received: by 2002:a6b:3bc7:: with SMTP id i190mr14992781ioa.145.1634567817823;
        Mon, 18 Oct 2021 07:36:57 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g20sm7056504ilk.64.2021.10.18.07.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:36:57 -0700 (PDT)
Subject: Re: [PATCH 12/14] block: align blkdev_dio inlined bio to a cacheline
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-13-axboe@kernel.dk> <YW08mkgxKdqM4cEs@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7e5ec23a-9b4e-d8e7-d420-f9ced17f5810@kernel.dk>
Date:   Mon, 18 Oct 2021 08:36:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW08mkgxKdqM4cEs@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 3:21 AM, Christoph Hellwig wrote:
> On Sat, Oct 16, 2021 at 07:37:46PM -0600, Jens Axboe wrote:
>> We get all sorts of unreliable and funky results since the bio is
>> designed to align on a cacheline, which it does not when inlined like
>> this.
> 
> Well, I guess you'll need to audit all the front_pad users for
> something like this then?

It's not a correctness issue, it's just less efficient. Not really
a new thing.

-- 
Jens Axboe

