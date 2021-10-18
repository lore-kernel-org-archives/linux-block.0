Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1475C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D18610A1
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhJRRJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:09:56 -0400
Received: from verein.lst.de ([213.95.11.211]:35175 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhJRRJ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:09:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0614268AFE; Mon, 18 Oct 2021 19:07:43 +0200 (CEST)
Date:   Mon, 18 Oct 2021 19:07:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [regression] ndctl destroy-namespace operation hang from
 5.15.0-rc6
Message-ID: <20211018170742.GA3074@lst.de>
References: <CAHj4cs87BapQJcV0a=M6=dc9PrsGH6qzqJEt9fbjLK1aShnMPg@mail.gmail.com> <CAHj4cs_XMKWZiW-6Xfion1mkH4jn7DnrDWq0g6Kg8HawcpHdCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_XMKWZiW-6Xfion1mkH4jn7DnrDWq0g6Kg8HawcpHdCg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 12:13:09AM +0800, Yi Zhang wrote:
> So the bisecting shows it was introduced with below commit:
> 
> commit 8e141f9eb803e209714a80aa6ec073893f94c526
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Sep 29 09:12:40 2021 +0200
> 
>     block: drain file system I/O on del_gendisk

I can reproduce this, and it seems due to the fact that the pmem
driver overloads q_usage_counter for it's purposes (pgmap refcounting).
Let me think a little more about what we can do here.
