Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E140C433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 20:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJRU3K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRU3J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 16:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC5AB806
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666124947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMVhy3cHiGqz/MOnCKPaKpNIigZafHAXb3j2u+VUQmo=;
        b=WVSxbUauYfmw/7VVtJw2xM6YFaM2PSctEepB7Me+You41HKIyVH/0GW9c4UfMLV8ixwjje
        nfzlEzoKMcpUe2wZRQ20jjnIBsBnotBz7Z70PfTnf6+/nQ971YuvCpVk84zestqv1eX3YK
        PXja2JwE4U8raMXShOOn0MnTE87v2oA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-1lcwU4qyP0WxsC7vHnnN0g-1; Tue, 18 Oct 2022 16:28:59 -0400
X-MC-Unique: 1lcwU4qyP0WxsC7vHnnN0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2002F185A7B0;
        Tue, 18 Oct 2022 20:28:59 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B5DFC15BAB;
        Tue, 18 Oct 2022 20:28:57 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 29IKSvAi010168;
        Tue, 18 Oct 2022 16:28:57 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 29IKSjqV010163;
        Tue, 18 Oct 2022 16:28:49 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 18 Oct 2022 16:28:43 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [git pull] device mapper changes for 6.1
In-Reply-To: <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2210181515170.23349@file01.intranet.prod.int.rdu2.redhat.com>
References: <Y07SYs98z5VNxdZq@redhat.com> <Y07twbDIVgEnPsFn@infradead.org> <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Tue, 18 Oct 2022, Linus Torvalds wrote:

> On Tue, Oct 18, 2022 at 11:17 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Oct 18, 2022 at 12:20:50PM -0400, Mike Snitzer wrote:
> > >
> > > - Enhance DM ioctl interface to allow returning an error string to
> > >   userspace. Depends on exporting is_vmalloc_or_module_addr() to allow
> > >   DM core to conditionally free memory allocated with kasprintf().
> >
> > That really does not sound like a good idea at all.  And it does not
> > seem to have any MM or core maintainer signoffs.
> 
> I wouldn't worry about maintainer sign-offs just for exporting a
> helper function, but I agree with the whole concept being a complete
> disaster and not a good idea at all.
> 
> Use errno.
> 
> It really is that simple. Strings have been discussed before, and they
> are simply not a good idea. If your interface is so complicated that
> you think errors need some textual explanation, your interface is
> probably garbage.
> 
> Strings also have allocation issues (as you found out), and have
> serious localization issues.
> 
> Yes, we do a lot of strings in the kernel in the form of dmesg, and we
> have the rule that we simply don't localize. But that's dmesg. It's
> for special stuff, not some interface.
> 
> And equally importantly, some really small detail in the kernel really
> has *NO* business making up new error models of its own. You may think
> that the DM ioctl's are a big and important deal, but realistically,
> it's just an odd corner of the world that very very few people care
> about, and they can use the same error numbers that EVERYBODY ELSE HAS
> BEEN USING FOR SIX DECADES!
> 
> Don't reinvent something that works - badly.
> 
> I think we have one major interface that is string-based (apart from
> the obvious pathname ones and the strings passed to 'execve()').
> 
> It's 'mount()' (and now fsconfig() etc), and it's string-based mainly
> because it has that nasty "arbitrary things that different filesystem
> may need for configuration"). And it has some nasty logging model
> associated with it too for output.
> 
> But no, we absolutely do *not* want to emulate that particular horror
> anywhere else.
> 
> If you think some errors are really important and hard to understand,
> maybe you can just log them with a ratelimited pr_info() or something.

This is what we currently do.

>            Linus

The error string is not intended to be parsed by userspace (I agree that 
parsing the error string is a horrible idea, but this is not going to 
happen). It is intended to be displayed to the user by tools such as 
cryptsetup or integritysetup. The tool can't read the log, extract 
messages from it and display them.

With "just use errno", the user sees messages like "device-mapper: reload 
ioctl on test (254:0) failed: No such file or directory" and it's not much 
useful because it doesn't tell what went wrong.

Try to type "grep -r 'ti->error = ' drivers/md/|wc -l". There are 480 
distinct error messages generated by device mapper. You can't map each of 
them to a unique errno number.


BTW. we were talking about replacing device mapper version numbers with 
feature bitmaps and people preferred textual lists of features instead of 
bitmaps (because the bitmap will overflow when you have more than 64 
features). Do you oppose to this too? Do you prefer a 64-bit feature 
bitmap or a string with comma-separated list of features?

Mikulas

