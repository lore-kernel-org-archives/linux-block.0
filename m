Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A33EB64DC
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 04:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjF2Emb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 00:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2Em3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 00:42:29 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550EB2132
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 21:42:28 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57045429f76so2456207b3.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 21:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688013747; x=1690605747;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOfSHSvnetiPIiAzH/sv81XhJUlB8fw91bEdXAnyaZw=;
        b=CmJJ25HrnL+JjraEoOS3sXf7YzWlSrhPDKo8KN1vnFy4R/XOUkxz8EkkCBrMpB7yCw
         AG5AOCgh4bVrQQsdoS9OzptfmAP4L/ynbz4JMWWKRkp3vJiAzFUjovjSOdSVYHiWhkBj
         ap0xpnPCMNVqNJfxIVdu6W/UrmJbaOm4D7pg4LNg7fVtsAkfbDWFKZjV70FXOBy8TmCq
         stgLrXU3F2Q1IhlpkXD0STjtEWfxVSd4mtTsUhvkBXNZiZGKVKBxL2flMcMetEylmFY1
         JvIKEmiVKthuGxMddAQVJTws7CQ/ULSnYSWHW9l1paidCwnMwPvAhOfhBnOxKNX1FHh1
         iOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688013747; x=1690605747;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOfSHSvnetiPIiAzH/sv81XhJUlB8fw91bEdXAnyaZw=;
        b=BU3W7/zvi8K6JFdu8ru9hnMZJITZVbnCl1tFLEYR5YzFuO8K1fGyRPjSzVvBUfFek3
         a2ytXDHq1sDKpm2Q/rvPeC2dJqA6N2xQf/DQKKVVlBuit+laRgYy0bFKHJyyZU7pzAoI
         z0Nk0o5nZiGHCbBPLst4gIcrF7n/jNlgVb5eVwCq7NrQsu3zEEaklB8vLkefPDFZVxlb
         HnX/rDXzbXC4VjHZDzD0AG0ijakIUyXlnS/jXJQ2bo5bO6qUH8+xBceyHCXOQGGHSE3D
         Czbu0bouaqElhRi5Q2DGtUNl1QQkjVRGjlZErmNQxg6im5M1qaRVscwb3GaeqePqT8cB
         uZ1A==
X-Gm-Message-State: ABy/qLZGYdI+oGwuIPojl7oHkWIhWSUKHpRDd+cb4XiUCsBLMdFu4cS2
        krlnnu0+0S1Rs5SKLsvqHU9dtQ==
X-Google-Smtp-Source: APBJJlHQCATTC4Wcb6fxdTfnRHkjimkFKMWchKkiRsoWwTB5FRzmzEae1Asb0cX7xRKcxqs0v3lmTg==
X-Received: by 2002:a0d:ccd7:0:b0:577:228f:467f with SMTP id o206-20020a0dccd7000000b00577228f467fmr1246483ywd.36.1688013747359;
        Wed, 28 Jun 2023 21:42:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q130-20020a817588000000b0057725aeb4afsm160224ywc.84.2023.06.28.21.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 21:42:26 -0700 (PDT)
Date:   Wed, 28 Jun 2023 21:42:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jens Axboe <axboe@kernel.dk>
cc:     David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next] shmem: minor fixes to splice-read implementation
In-Reply-To: <168173931746.319007.17265276905089710599.b4-ty@kernel.dk>
Message-ID: <b0db88cd-c0bd-bb18-dfd3-382b18c8f9@google.com>
References: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com> <168173931746.319007.17265276905089710599.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 17 Apr 2023, Jens Axboe wrote:
> On Sun, 16 Apr 2023 21:46:16 -0700, Hugh Dickins wrote:
> > generic_file_splice_read() makes a couple of preliminary checks (for
> > s_maxbytes and zero len), but shmem_file_splice_read() is called without
> > those: so check them inside it.  (But shmem does not support O_DIRECT,
> > so no need for that one here - and even if O_DIRECT support were stubbed
> > in, it would still just be using the page cache.)
> > 
> > HWPoison: my reading of folio_test_hwpoison() is that it only tests the
> > head page of a large folio, whereas splice_folio_into_pipe() will splice
> > as much of the folio as it can: so for safety we should also check the
> > has_hwpoisoned flag, set if any of the folio's pages are hwpoisoned.
> > (Perhaps that ugliness can be improved at the mm end later.)
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] shmem: minor fixes to splice-read implementation
>       commit: 72887c976a7c9ee7527f4a2e3d109576efea98ab
> 
> Best regards,
> -- 
> Jens Axboe

Thanks, but it then vanished amidst the subsequent splice convulsions,
and I can't quite tell how much of it is still needed - looks like the
!len check is now done in vfs_splice_read(), but I didn't work out
what happened to ppos and s_maxbytes; the hwpoison and "part" mods
still needed, surely?

Hugh
