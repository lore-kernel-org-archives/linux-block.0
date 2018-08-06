Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729692AbeHFPKi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Aug 2018 11:10:38 -0400
Subject: Re: bcache-tools repo?
To: Rolf Fokkens <rolf@rolffokkens.nl>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180315104240.24647-1-colyli@suse.de>
 <a0f8c2c5-6717-36d7-7ee8-ee1720eef268@rolffokkens.nl>
From: Coly Li <colyli@suse.de>
Message-ID: <2b4bd5e7-41b5-1865-c785-e33ca42cca81@suse.de>
Date: Mon, 6 Aug 2018 21:01:25 +0800
MIME-Version: 1.0
In-Reply-To: <a0f8c2c5-6717-36d7-7ee8-ee1720eef268@rolffokkens.nl>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/8/6 2:39 AM, Rolf Fokkens wrote:
> Hi,
> 
> I'm the maintainer of the bcache-tools package for Fedora, and bcache
> tools has been quiet for a while so I wasn't paying attention. But I
> accidentally noticed there's stuff going on again with bcache tools. I
> did a quick search in the mail archives to see where the new
> bcache-tools git repository is (I think
> https://bcache.evilpiepirate.org/ doesn't point in the right direction),
> and I'm not able to find it.
> 
> Could anybody point me to the git repo that contains the latest
> bcache-tools?

Hi Rolf,

So far we don't have any change to bcache-tools, there are some changes
in progress, notable once are big endian support and bcache-ctl.

Big endian support is still under developing. bcache-ctl seems to work
well so far, but the author does not post patch yet.

I tend to keep all the changes in https://bcache.evilpiepirate.org until
it is necessary to change the git repo.

Thanks.

Coly Li
