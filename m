Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48825 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750717AbdASIem (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 03:34:42 -0500
Subject: Re: [LSF/MM ATTEND] block: multipage bvec upstreaming & next step
To: Ming Lei <tom.leiming@gmail.com>
References: <CACVXFVO2hPfu1G_ASzHLVvFgDdVR8HTNitGPVYRbq-ovMNabAw@mail.gmail.com>
Cc: lsf-pc@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From: Coly Li <colyli@suse.de>
Message-ID: <cd3be689-9f7c-d5ad-1482-1d45944bed66@suse.de>
Date: Thu, 19 Jan 2017 15:57:33 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVO2hPfu1G_ASzHLVvFgDdVR8HTNitGPVYRbq-ovMNabAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/1/17 上午11:56, Ming Lei wrote:
> Hi Guys,
> 
> The multipage bvec patchset[1] has been posted out for a while, and
> xfstest(ext4, xfs and btrfs) have been run and no regression is
> observed, and I hope having talk about this in person would help
> moving it forward.
> 
> Secondly I'd like to discuss with guys about the following next steps
> of mp-bvec:
> 
> 1) cleanup raid1/raid5/raid10 for removing the only singlepage bvec path

Hi Ming,

I am interested on this topic. Could you please provide a hint that what
is the proper way to remove single page bvec from md raid code ? And
will dm code involved in as well ?

Thanks.

Coly
