Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7CC433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 19:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiCGTvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241478AbiCGTu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 14:50:59 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C66C50041
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 11:50:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d62so18299038iog.13
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=iYzvICBpRK+Z1lkcKMGBj85WSLhaFfQKUQR/1tbsVi0=;
        b=D9EOkrsYV7Xsyxf/6CdXzNXALautOeZBiGjeX/I4hjBM8EynsqoHdUlfNoDp+n97Cx
         ak3LSSmjyVYTrUo3k8wUJ/vzRpIHWWk2A1GZUSlCpFOfDx8AVtsHh7/RvdGmbKIXfOBC
         YVz8ptxroGcIhO1e7z2glBGmsSfeQ1TB8MJIyJfzlEnsrLK68ilH9PTwj96YEXzZAGUU
         tXTF1Wvp5ogod/B+rQzAQLizXotw0U4w14DYF56LdpsZt8PsTNM1yIYfEEx+43rDvjJU
         HF9j6lUn/42Oauqt03YtKhF3B1Gfi30Qoe60vsMifkKbkyB5LAaFvaavy4m5SElM4DZf
         RjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=iYzvICBpRK+Z1lkcKMGBj85WSLhaFfQKUQR/1tbsVi0=;
        b=tbIPnurYaZDAob6JK3JYoJqhlfxKccsc6rmRduIoN0u+SkRIWV/A+wk6uK5ybMHuSn
         j95yEheTzpkzjGrkbE6ZYNbL89EzauXVuniKUdj9wSlHHP2WZTNOwUDxxkAVIJ9NjjFb
         US465jPd+G96o5dQ54NvXScuWYYwMqWdy8Q9HMGFgj5eQgo9DpXwX3QUprczoWRB/KQE
         8KdYhzvy4csQdrCZSIulGH9TZRi8gJvQmK2msH+vL061f34mEALmw20bR/P8GwkURgsN
         Ntf+uY/4O67zJ0bvGrTqb3CKkuxFy9IxK4JeiDNnGNXlt1lekHYur9jZUrKs5rKKbm+4
         5LcQ==
X-Gm-Message-State: AOAM533CRU1Qm4P2S+aocXjrayer/eSPYFSyFL3hdjXAvWkzgHwAWPER
        ZoOvwjsDrvKWD3/3eeNhRcfvYYfgld7oC893
X-Google-Smtp-Source: ABdhPJybq+mzRA9wXefyDpbSCzRp9JiXKbIPz1Fc1EWfxA+XSQ7k68avZwGrMkTiAo8s8+pRBO+9cg==
X-Received: by 2002:a02:5bc2:0:b0:317:b050:cba with SMTP id g185-20020a025bc2000000b00317b0500cbamr8910432jab.301.1646682602578;
        Mon, 07 Mar 2022 11:50:02 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s13-20020a056e0218cd00b002c5f74a97d6sm11807418ilu.39.2022.03.07.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:50:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, hch@lst.de
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
Subject: Re: [PATCHv4 0/8] 64-bit data integrity field support
Message-Id: <164668260179.56567.6298714072189307417.b4-ty@kernel.dk>
Date:   Mon, 07 Mar 2022 12:50:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 3 Mar 2022 12:13:04 -0800, Keith Busch wrote:
> The NVM Express protocol added enhancements to the data integrity field
> formats beyond the T10 defined protection information. A detailed
> description of the new formats can be found in the NVMe's NVM Command
> Set Specification, section 5.2, available at:
> 
>   https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification-1.0b-2021.12.18-Ratified.pdf
> 
> [...]

Applied, thanks!

[1/8] block: support pi with extended metadata
      commit: c340b990d58c856c1636e0c10abb9e4351ad852a
[2/8] nvme: allow integrity on extended metadata formats
      commit: 84b735429f5fe6f57fc0b3fff3932dce1471e668
[3/8] asm-generic: introduce be48 unaligned accessors
      commit: c2ea5fcf53d5f21e6aff0de11d55bc202822df6a
[4/8] linux/kernel: introduce lower_48_bits function
      commit: 7ee8809df990d1de379002973baee1681e8d7dd3
[5/8] lib: add rocksoft model crc64
      commit: cbc0a40e17da361a2ada8d669413ccfbd2028f2d
[6/8] crypto: add rocksoft 64b crc guard tag framework
      commit: f3813f4b287e480b1fcd62ca798d8556644b8278
[7/8] block: add pi for extended integrity
      commit: a7d4383f17e10f338ea757a849f02298790d24fb
[8/8] nvme: add support for enhanced metadata
      commit: 4020aad85c6785ddac8d51f345ff9e3328ce773a

Best regards,
-- 
Jens Axboe


