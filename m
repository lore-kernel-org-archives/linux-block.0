Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D99DC433B4
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA7661078
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 21:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCaV6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 17:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhCaV6I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 17:58:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6438061002;
        Wed, 31 Mar 2021 21:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617227887;
        bh=tpoYiSlNk4uwdNJnLdLuFZS9y1Ke2MOr3SuY8iUfrG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8xr6TMOly7cQ3WLUHc4Pai3QxsiNd8PjsPyKEei7jDZQMlnWXa8jO7v+sbq0Oqh/
         jOcIWW+2Qgx1VRBcs9VTVrHfvlFPTeSTipLSRLzuPCvfssKyPPGTXe6GS+n7hjLi0P
         Ceq3PDS5eJtNTHqp3cHrT42/+hJy0gSO9czD4iA/EJfoPAeInPUp+ILK+2OrjDPFeT
         p+v92MatlkQL62wnwv9/3SSP92FMMEkzDWu/hx7eeidGmWxM6K0pOZ0cpo+Onu1wpZ
         A02nIpALgnrQCRKMUUsHV7rGtuZxL1ZuBf3VzgclSzy4Du8vB61KrwSLXkkJaM+Uoi
         iqsGGn8V2v6PQ==
Date:   Wed, 31 Mar 2021 14:58:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jian Cai <jiancai@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
Message-ID: <20210331215802.r4rp6wynjqutdoup@archlinux-ax161>
References: <20210330230249.709221-1-jiancai@google.com>
 <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net>
 <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
 <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jian,

On Wed, Mar 31, 2021 at 02:27:03PM -0700, Jian Cai wrote:
> Hi Nathan,
> 
> I just realized you already proposed solutions for skipping the check
> in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
> Do you have any plans to send them for review?
> 
> Thanks,
> Jian

I was hoping to gather some feedback on which option would be preferred
by Jens and the other ClangBuiltLinux folks before I sent them along. I
can send the first just to see what kind of feedback I can gather.

Cheers,
Nathan

> On Tue, Mar 30, 2021 at 6:31 PM Jian Cai <jiancai@google.com> wrote:
> >
> > Thanks for all the information. I'll check for similar instances and
> > send an updated version.
> >
> >
> > On Tue, Mar 30, 2021 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On 3/30/21 4:29 PM, Nathan Chancellor wrote:
> > > > Hi Jian,
> > > >
> > > > On Tue, Mar 30, 2021 at 04:02:49PM -0700, Jian Cai wrote:
> > > >> This fixes the mismatch of alignments between csd and its use as an
> > > >> argument to smp_call_function_single_async, which causes build failure
> > > >> when -Walign-mismatch in Clang is used.
> > > >>
> > > >> Link:
> > > >> http://crrev.com/c/1193732
> > > >>
> > > >> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> > > >> Signed-off-by: Jian Cai <jiancai@google.com>
> > > >
> > > > Thanks for the patch. This is effectively a revert of commit
> > > > 4ccafe032005 ("block: unalign call_single_data in struct request"),
> > > > which I had brought up in this thread:
> > > >
> > > > https://lore.kernel.org/r/20210310182307.zzcbi5w5jrmveld4@archlinux-ax161/
> > > >
> > > > This is obviously a correct fix, I am not just sure what the impact to
> > > > 'struct request' will be.
> > > >
> > >
> > > As commit 4ccafe032005 states, it increases the request structure size.
> > > Given the exchange referenced above, I think we'll need to disable
> > > the warning in the block code.
> > >
> > > Thanks,
> > > Guenter
> > >
> > > > Cheers,
> > > > Nathan
> > > >
> > > >> ---
> > > >>  include/linux/blkdev.h | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > >> index bc6bc8383b43..3b92330d95ad 100644
> > > >> --- a/include/linux/blkdev.h
> > > >> +++ b/include/linux/blkdev.h
> > > >> @@ -231,7 +231,7 @@ struct request {
> > > >>      unsigned long deadline;
> > > >>
> > > >>      union {
> > > >> -            struct __call_single_data csd;
> > > >> +            call_single_data_t csd;
> > > >>              u64 fifo_time;
> > > >>      };
> > > >>
> > > >> --
> > > >> 2.31.0.291.g576ba9dcdaf-goog
> > > >>
> > >
