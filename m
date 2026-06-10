Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729226FD9B
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130436; cv=none; b=bc5j96htL9NOFtxTc2duIAfCjdHOGRZqDQkMf3kVaevcabTKeAdUXPfg4M7HAzlVttJPVoFvSDlzaH+iS6Aj8zLCtPmWPRHcQ88gm36e1cEqjA6hgKG+7zNPzSRn0GIMXMuO+HA8ydEQ4F3g+DYjRhSx2C9b8dvmQpmya+eYSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130436; c=relaxed/simple;
	bh=1cQ/0cWbfEBqHI5r0H10tWo99TR+KBIClcsmuqhCU2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlbkNFr4hvSKZNfGrgKLbBZpKfqueqz/l9DgkYxlZhvGaYcvNGeBCBlcEUN7XdJf8Wv/TvYTZnxfI5n1RJWLVbTg6n3xd+gQAyo/zdXyi+XviZr1JkacOXOwXKpP6ZaNb9ldzkFqYYJuJ+woOYufrIh/F4DFbmEUTiC+Kxnycas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul/h5e1v; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul/h5e1v"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so179927f8f.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130434; x=1781735234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ERJnitgYeN+oHp0QIhM2Gx0sT2CNtRoOhhriDExY+yw=;
        b=Ul/h5e1vpBOCb3nE7pvmbf5uxlRGzQM+y8jdIEYplelFlyJqriZyrljmpVEh4cumDf
         SxI/CTHNXM2fmP4SCcCc6pL6QTvjB1SNmubNn3pRalH9FZ2ymRmJypwbY0cizHWjNoGa
         6DO3cU06By59KmwdXxpfBdHowyKrY6ooRNm876jacdOeHx9VXiszNYzJ6VRoAJhiABPl
         FvIBy7Lw3nv7CFdKKFkkRDrIfliBJFiE8Q+uykwDULTCw+HCCJw16KgJ3XMWAOrr9pHW
         SeQb9MfdF20VW1YCRF2pwJpTmGKe2niIP0K8ciQE9M2btmTQ5WTY5GlNZnTqDS/BHZq7
         xygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130434; x=1781735234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERJnitgYeN+oHp0QIhM2Gx0sT2CNtRoOhhriDExY+yw=;
        b=P+cswrz5MfApK1Gl89gKXhhxNMzVQBJa8VqZWosBIS4IUm7VKZUlwe5qrEoF/1noAo
         FmA0Hknsp0SrKaIb5rMzZqvb3G7N41MGkwUOIq8U2nDEJzrnf95x57Dvbn/0gUiH3cof
         jkG3H01losf6gFVoQviZleb0dr9XP1lCYunqdgXQWr2uSb7jJpoNYrIv6VPT9WnXO8cg
         sIJDY0sUf8Eq142AwveSE5kYbAFIWFPKGYXyx41h5LlyCEiCAciyOC5Q8U7nhGmOfXrc
         t5VgUNFY4MnotP6hE6Y1/KgAniMwBdP96mDfOViruBkCeE5rEZQ2vS7oIzlWMjpoe9DQ
         hXDg==
X-Forwarded-Encrypted: i=1; AFNElJ++MazIxGc997LKdrJpLn3vy9rSTRev/b78xoXJPFx52/HB/T4KiIeN4i32HlDfhcUG5FSiYBW9kZHotQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71fumQVIK+k43za/xPywQFp5gTrwKVoxWzSvb2K/doJes78TD
	jbA3v7Pn3xoWYAD1kkGCCubyz67XMwnvjl3+8su0vMplAlIZm4eahppd
X-Gm-Gg: Acq92OHPNCHCZIrVmFhXT6jcfTAYM5kzOG5WlBi9y/vnFCXLpRiq10UvGk6MJG6By2F
	E25pTGuQhczJov2rQTIG1GOHHYQz+cho818E6aHuvYI2Zlq5X7ATyJm9kozpLptGYcdMiTno1aE
	tSUz5mRk/TKVu+MjfHjZ56fcPo8lkDtp4iEGGb4Pez2D2EqZg0YmIV0vfLyEYHOyN00752PmPT5
	LfDg7rHaL99qA4SdZRvTDa/f1RUJWlhy5sTJIrXcyEebVDl/OU3wwSSO4KE5TyQeNQGhv6B7Prg
	+mzPsP4YLdVxYcTzE+5zyYYVhj+CoAoIBE+pMLrECdw/TtU7SDHQBv8h7EEsDDwBtJ4+YA9sZhk
	k4vderSc90uycTtVm8UsVydMGz8jr3MHNhUyt9TypT5wNB7uPQrFnnE+VQq43KOwxJFBRxTQBZK
	t8EJ2hJ9sLE5Q5tvfM20xd81AQFwuCrrNkHEiOcc0/tQBp1AegB/RQ8YLMNy5VNkhqluSrhtnWR
	nrSPZHxcAyRgcgEjR2A7Djz52Y0rE3m5rCPuZq5tDE/ow==
X-Received: by 2002:a05:6000:461a:b0:460:d18:865c with SMTP id ffacd0b85a97d-460664c54bbmr512993f8f.1.1781130433530;
        Wed, 10 Jun 2026 15:27:13 -0700 (PDT)
Received: from localhost (pat-125-253.wlan.net.ed.ac.uk. [192.41.125.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm80574537f8f.6.2026.06.10.15.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:27:12 -0700 (PDT)
Date: Wed, 10 Jun 2026 23:27:12 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <20260610222712.cmbforeivf7h544y@wrangler>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>

On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> I (together with the Czech Technical University) did some experiments trying
> to measure memory fragmentation with large block sizes.
> Testbed used was an nvme setup talking to a nvmet storage over
> the network.
> 
> Doing so raised some challenges:
> 
> - How do you _generate_ memory fragmentation? The MM subsystem is
>   precisely geared up to avoid it, so you would need to come up
>   with some idea how to defeat it. With the help from Willy I managed
>   to come up with something, but I really would like to discuss
>   what would be the best option here.

thpchallenge from mmtests has been a staple for the compaction/anti
fragmentation folks.

And check this https://patchwork.freedesktop.org/patch/716404/?series=164353&rev=1

Btw, do you mind sharing what workloads you discussed with Matthew?

> - What is acceptable memory fragmentation? Are we good enough if the
>   measured fragmentation does not grow during the test runs?
> - Do we have better visibility into memory fragmentation other than
>   just reading /proc/buddyinfo?
> 
> And, of course, I would like to present (and discuss) the results
> of the testruns done on 4k, 8k, and 16k blocksizes.
> 
> Not sure if this should be a storage or MM topic; I'll let the
> lsf-pc decide.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

-- 
~karim
