Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D6C46467
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 15:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiESPwC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbiESPqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 11:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B19F2CC152
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652975070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHo4viihgLRt7UNPxe5xxzFkQUkDA+qFFkKh1E4W9Ek=;
        b=Q+6c0QBJ8lgqYC2u8gS0AMqxJH2ZHdb8X2OpBgbiXvDAQu3rXC97moRNzGvbKa5sPu9lvM
        0gd6VNp98S2ccX5egFmnbl7FfhWLh6yN5YsRBkg/AZaryA/emGxj2VgUHF3U+wgirwmHFE
        2HQ3pzKVKceQq5g1N4q2rK//g+zYe8I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-PL-E3_MqPSqglGr1r5w6Nw-1; Thu, 19 May 2022 11:44:29 -0400
X-MC-Unique: PL-E3_MqPSqglGr1r5w6Nw-1
Received: by mail-qv1-f70.google.com with SMTP id c9-20020a056214146900b00461c7b83672so4590260qvy.7
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 08:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHo4viihgLRt7UNPxe5xxzFkQUkDA+qFFkKh1E4W9Ek=;
        b=2E4ulreSTrmvTomABCjgXuRvOsH1+tHe//0toW4Ky+GztD4Zu7bVPY6P4UnwDZ8cWR
         yH40UE2x6GDLehH3ATVXRj+l2TlsYV6SkGZGstaAFby78+jNB5JplREfr+jQIWOmO8xG
         iUNL0YaKioznIhD88gia5sFfEKffXw+WpA4qZkJ+TAr+AwS6X7UE86J9uEDXFHtUMuyn
         XN8sjYzijp6KaqNI5KnoeD490CUJ8gt/oHVYIv1VZWHxDyH498Yxe8lHfG+gBmEpBD9t
         iopVAFI97B5gIsdq8ilzutlJs0uB9kWSIC8mBnkaGWlh7q0oNX7XNNClpMaByPc1FKsx
         TJhA==
X-Gm-Message-State: AOAM530xz9LzvsA1EIkmmyf/QC8SV1zRuLvpY0po/jUVSRugP/KilyMY
        s7lROEQZ9hHGykWkyzmC45YYSHY/1dz+tIlxVJ5P/BBpqXY9bKBXgNBPoLv0vFiGeE1iZvbUFLc
        xUycJzt5LRlGcyRHu9KJBkBc=
X-Received: by 2002:a05:622a:134d:b0:2f3:bd4b:68d with SMTP id w13-20020a05622a134d00b002f3bd4b068dmr4279946qtk.169.1652975068743;
        Thu, 19 May 2022 08:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK/zb4CcD5/OFHJlpmWZ/bU5MeXCrj0CA31HfJq/aphmpdiDzdQIQTXwM2JY1a6elLAPXyng==
X-Received: by 2002:a05:622a:134d:b0:2f3:bd4b:68d with SMTP id w13-20020a05622a134d00b002f3bd4b068dmr4279930qtk.169.1652975068483;
        Thu, 19 May 2022 08:44:28 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i2-20020ac813c2000000b002f39b99f689sm1415292qtj.35.2022.05.19.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:44:27 -0700 (PDT)
Date:   Thu, 19 May 2022 23:44:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZbF90qS+LlSDfS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZbF90qS+LlSDfS@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 03:58:31PM +0100, Matthew Wilcox wrote:
> On Thu, May 19, 2022 at 07:24:50PM +0800, Zorro Lang wrote:
> > Yes, we talked about this, but if I don't rememeber wrong, I recommended each
> > downstream testers maintain their own "testing data/config", likes exclude
> > list, failed ratio, known failures etc. I think they're not suitable to be
> > fixed in the mainline fstests.
> 
> This assumes a certain level of expertise, which is a barrier to entry.
> 
> For someone who wants to check "Did my patch to filesystem Y that I have
> never touched before break anything?", having non-deterministic tests
> run by default is bad.
> 
> As an example, run xfstests against jfs.  Hundreds of failures, including
> some very scary-looking assertion failures from the page allocator.
> They're (mostly) harmless in fact, just being a memory leak, but it
> makes xfstests useless for this scenario.
> 
> Even for well-maintained filesystems like xfs which is regularly tested,
> I expect generic/270 and a few others to fail.  They just do, and they're
> not an indication that *I* broke anything.
> 
> By all means, we want to keep tests around which have failures, but
> they need to be restricted to people who have a level of expertise and
> interest in fixing long-standing problems, not people who are looking
> for regressions.

It's hard to make sure if a failure is a regression, if someone only run
the test once. The testers need some experience, at least need some
history test data.

If a tester find a case has 10% chance fail on his system, to make sure
it's a regression or not, if he doesn't have history test data, at least
he need to do the same test more times on old kernel version with his
system. If it never fail on old kernel version, but can fail on new kernel.
Then we suspect it's a regression.

Even if the tester isn't an expert of the fs he's testing, he can report
this issue to that fs experts, to get more checking. For downstream kernel,
he has to report to the maintainers of downstream, or check by himself.
If a case pass on upstream, but fail on downstream, it might mean there's
a patchset on upstream can be backported.

So, anyway, the testers need their own "experience" (include testing history
data, known issue, etc) to judge if a failure is a suspected regression, or
a known issue of downstream which hasn't been fixed (by backport).

That's my personal perspective :)

Thanks,
Zorro

> 

