Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33451 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdHRIW3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 04:22:29 -0400
Received: by mail-yw0-f173.google.com with SMTP id p68so54929937ywg.0
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 01:22:29 -0700 (PDT)
Date: Fri, 18 Aug 2017 01:22:26 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Karel Zak <kzak@redhat.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
Message-ID: <20170818082226.GK2459@vader>
References: <cover.1503036471.git.osandov@fb.com>
 <9ff9b291e3e872698a040a281549c39c0637565f.1503036471.git.osandov@fb.com>
 <c54bc65f-7106-0dee-77dc-32bbaf1a3d1d@suse.de>
 <20170818073838.GG2459@vader>
 <3f01f907-0443-4961-d4fd-a5a3ffe8e688@suse.de>
 <20170818074700.GH2459@vader>
 <d5d61484-9aa9-5161-8abf-cce924521df1@suse.de>
 <20170818080539.GI2459@vader>
 <3a42bb8d-1850-8d6c-11c6-bf8632af5e7a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3a42bb8d-1850-8d6c-11c6-bf8632af5e7a@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 18, 2017 at 10:12:51AM +0200, Hannes Reinecke wrote:
> On 08/18/2017 10:05 AM, Omar Sandoval wrote:
> > On Fri, Aug 18, 2017 at 09:56:26AM +0200, Hannes Reinecke wrote:
> >> On 08/18/2017 09:47 AM, Omar Sandoval wrote:
> [ .. ]
> >>>
> >>> I actually checked losetup, it works just fine with LO_FLAGS_BLOCKSIZE
> >>> always set and lo_init[0] always filled in.
> >>>
> >> The original argument I had with the util-linux maintainer did not
> >> revolve so much around technical details :-)
> > 
> > Karel, what were your concerns here?
> > 
> It wasn't Karel, it was our guy.
> Doesn't make it any better, though...

I just went through the code and util-linux doesn't mention lo_init at
all except for the definition, and everywhere it's using lo_flags would
work fine with the behavior I implemented here. Unless there's an actual
issue someone can point out, I see no reason to not do it this way.
