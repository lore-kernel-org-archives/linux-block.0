Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579B298CAB;
	Wed,  5 Aug 2026 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893177; cv=none; b=cmIigCv1XhTiVhLp+94QEAhhTgfJC076K0LDOUba10FGl56CBIySeNeK1WAc6TfSnvtSz2HGKbJ6OkrLRycpG4xRu/2kp8tRH/aHS4KIH8em2Y1UGTMCx9K2ie5b0wI66CFwmWSsBaKGhmJvvdQffxlpYBvzP44RfWaBJgga9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893177; c=relaxed/simple;
	bh=Y+tnwVr2Ja8lR+QQuUGWvw4oSWgxy5ozpDEskatU/VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbUg8BnaVRQ6iDlhches1RLytYNTMtzPrnuL3/8dU0d94la08AzzTLGcBUoQie3RdXkYCras1ObiRySlVSZWJRFosN0utT89Fyb0Wz+8HRvA+rfpga77c0sWBF1Nmt1bthqI05b5BLY9V9bFl81A3JiCUns+rctje8sg3bQ1jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7mNLcDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7mNLcDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B8F1F000E9;
	Wed,  5 Aug 2026 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785893175;
	bh=RjB5UbMgEH+fadVKrw/dy/5s6yUledcJxc4bfMv8qu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X7mNLcDrFEB4Tf3nzdJw55mPnMIZp3XUBD7jrTkOsH6adrH6BL1evXW1XK3Vu5FOT
	 zzzkAetM2iMyNP6D+G66whLHr6feZu66vjZwnwDLy0CFnnrb3RMZyg1EY/cYnAniWe
	 Ej96D1Dxc4lVBd4Q392xs81mKauUOi8lwX/xGIf3QDaPgbnkMiz3lyFCr83X7q5+vO
	 BZKTODrV/A9grZiJt9FvvKqpah6A3qiaMED29xAGMFKF6Hm1hNqmqYMtyp6Z8xnNCO
	 JtHjB/bkLXcMyMWc095EQVrpN2TZECxdSc4UIovy70v0N/LsepnQ4iX1i3Rm7j+zru
	 f6LeBViG7AUCQ==
Date: Wed, 5 Aug 2026 01:26:13 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: haoqin huang <haoqinhuang7@gmail.com>, Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <anKRNeeIKO9K7Z2r@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-4-haoqinhuang7@gmail.com>
 <amr3P_4zxX2w7ZNR@google.com>
 <CAEjiKSkExTnRc77Va-cOSpoNJ4S0i_-r2-iGFyxoSw2mqh1Diw@mail.gmail.com>
 <anFspPi023HFlwwE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anFspPi023HFlwwE@google.com>

On 08/04, Sergey Senozhatsky wrote:
> On (26/08/03 20:20), haoqin huang wrote:
> > On Thu, Jul 30, 2026 at 3:24 PM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > > > diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> > > > index f6a336acfe20..5d551d165213 100644
> > > > --- a/drivers/block/zram/backend_lz4hc.c
> > > > +++ b/drivers/block/zram/backend_lz4hc.c
> > > > @@ -20,6 +20,11 @@ static int lz4hc_setup_params(struct zcomp_params *params)
> > > >  {
> > > >       if (params->level == ZCOMP_PARAM_NOT_SET)
> > > >               params->level = LZ4HC_DEFAULT_CLEVEL;
> > > > +     else if (params->level < LZ4HC_MIN_CLEVEL ||
> > > > +              params->level > LZ4HC_MAX_CLEVEL) {
> > > > +             pr_err("lz4hc: invalid compression level %d\n", params->level);
> > > > +             return -EINVAL;
> > > > +     }
> > >
> > > So...  lib/lz4/lz4hc_compress.c supports levels 1 and 2.  However,
> > > LZ4HC_MIN_CLEVEL is set to 3, but clearly the compression library
> > > supports levels lower than LZ4HC_MIN_CLEVEL.  In fact, LZ4HC_MIN_CLEVEL
> > > is never used in the lz4 code.  Maybe here we need to just hardcode
> > > "< 1" and put a comment:
> > >
> > 
> > My bad, completely missed that LZ4HC_MIN_CLEVEL is advisory and the
> > library actually accepts 1-2.  Will hardcode < 1 in v5.
> 
> No worries, that LZ4HC_MIN_CLEVEL thing is difficult to spot.
> 
> > Btw, would it make sense to fix LZ4HC_MIN_CLEVEL to 1 in the lz4
> > header as a separate cleanup?  It seems misleading as-is.
> 
> I'm afraid we cannot do that.  f2fs uses LZ4HC_MIN_CLEVEL, I assume
> compression level is stored per-inode?  So if we change LZ4HC_MIN_CLEVEL
> then newer f2fs will start accepting compression levels that older kernels
> don't support.  Cc-ed Jaegeuk and Chao just for visibility.

Yeah, since we have

 239         clevel = le16_to_cpu(ri->i_compress_flag) >>
 240                                 COMPRESS_LEVEL_OFFSET;

 255 #ifdef CONFIG_F2FS_FS_LZ4
 256 #ifdef CONFIG_F2FS_FS_LZ4HC
 257                 if (clevel &&
 258                    (clevel < LZ4HC_MIN_CLEVEL || clevel > LZ4HC_MAX_CLEVEL))
 259                         goto err_level;
 260 #else
 261                 if (clevel)
 262                         goto err_level;
 263 #endif
 264 #endif
