Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC7C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 01:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8144F61356
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 01:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhHWBSf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:18:35 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38403 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhHWBSe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Aug 2021 21:18:34 -0400
Received: by mail-pf1-f182.google.com with SMTP id a21so13940802pfh.5
        for <linux-block@vger.kernel.org>; Sun, 22 Aug 2021 18:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8rKCTzPdA7YjtECcP4r7vZUL22zEbJSycRQTA9LMUY=;
        b=Gue8jvyF1xl3CzVvTqKOxV+T0Heo88FRPUxhBlRbWdCRlxXx+CbArFMI+tdNFg/Cb4
         mBN70SzkGcHA3jvbninkomBWdhqa9WYX0R9kWJa09hZARAD8XSpBvtRdMO4aZMV3yp+a
         VLPkHZ85EaV54lkHdK2lx4tDD/5U17Hso/4L0Ms6Ju5sj5sRO0AiKrwwDc+n7WBLDFyE
         MPaNajKOCkKVKrzKYk+9QPoeMYxT4GBqi5yQt5lfuVgegZFHzjqa5/6L8e7QjA+DNQIU
         lO22z4N4fhBiqBk3ynfO1tDVUOMo8Y3yEV29in8X62RJaQ+vja2gVFs0ent8qtLsxeMG
         3QKQ==
X-Gm-Message-State: AOAM531iN3+KAXyBuOmKe9AYrxMJ6NBB4/mAoihsYsXyeZWJ3uRsQDSy
        OkjMCJtDHA+RTs/DEzWDZAGJMmzsm7s=
X-Google-Smtp-Source: ABdhPJyvjtPzJeygP9Ubs6NRpO72UzaZPFc6Htd2UyfgOeDwlTx3CNSq+LYAd5MgyYYdp1G38FvmkA==
X-Received: by 2002:a62:778e:0:b0:3ea:e8fe:d0c7 with SMTP id s136-20020a62778e000000b003eae8fed0c7mr15761108pfc.21.1629681472433;
        Sun, 22 Aug 2021 18:17:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a7d0:e7bd:908a:e520? ([2601:647:4000:d7:a7d0:e7bd:908a:e520])
        by smtp.gmail.com with ESMTPSA id l2sm13337139pfc.157.2021.08.22.18.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 18:17:51 -0700 (PDT)
Subject: Re: Use-after-free related to dm_put_table_device()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <a5057305-9864-df8c-0657-ff33c85dc4f6@acm.org>
Message-ID: <f340d947-501a-6076-8f43-8ac65c2ea47a@acm.org>
Date:   Sun, 22 Aug 2021 18:17:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a5057305-9864-df8c-0657-ff33c85dc4f6@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/21 8:12 PM, Bart Van Assche wrote:
> If I run blktests nvmeof-mp/012 then a KASAN use-after-free complaint
> appears. Since I haven't seen this warning with previous kernel versions,
> I think this is a regression. Given the presence of bd_unlink_disk_holder()
> in the call trace, can you take a look Christoph?

(replying to my own e-mail)

Reverting commit fbd9a39542ec ("block: remove the extra kobject reference
in bd_link_disk_holder") makes the KASAN complaints disappear. However, the
srp tests and one other test fail with that commit reverted:

root:software/blktests# grep -rli status.fail . | sort
./results/nodev/nvmeof-mp/001
./results/nodev/srp/002
./results/nodev/srp/007
./results/nodev/srp/009
./results/nodev/srp/011
./results/nodev/srp/012
./results/nodev/srp/013
./results/nodev/srp/014

Bart.
