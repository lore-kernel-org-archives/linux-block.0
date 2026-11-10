Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329080;
	b=rK2ZGBj/A93HzKg2Ewsyj9ZKecfcZtl0nWioBSm5jHoSSmwSSNrssuLhWkVrxgcxV6MZ
	 qNSkmpD4dPhKzVhZsxgGrFKDXxtmxgx2PNiXJFGanvJfZF0wB5aPYMyJzmPILs8Z0dXrS
	 4z2b8WTIhW7v+GKIrSiTKdwgPUSRvsZLkbJ4/8qMtyptSQ8UNC34MvPByCjSfiwq9pWTJ
	 ZszJbJPEG2+u9rxYDWbxhEEtmoYdifQv670qeVRUQof9W3ABUcP28AkvahG0Nom6jh0Al
	 zPqiEiKLxawqyXkejvz2bgyY02roU9lBAD3+9ukbj1RMNw16H6X6+co8fXzSnOzgywQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8/qfX2R+fE5TFU8gL1lYbWbnT1+3dpcnTBXBU/PkfAg=;
	b=tDbbyNnMUhBke4U206rJSNRkLouQeBr6UvhhsDJV4auWLoY27431DT9cbzGfab1Gk49L
	 QpIY1lUm5ZXZcnRGSd4aVG3hgGFWu4Uefl79oVj7ULTgCozCROGZuWPKrh9WoZb/DQyGF
	 Gruxjt/SK18EKURDTBygOImncVJC1/YFO9g8Z29Y8E8H3hD31scTVaxOzKEi5qXQN+H+/
	 6kOJ6CoVXoWWwjm43HaUzNyeBbzebHIzMLiR27TWCIeJ+yV/ku6VkIynKhoL3N/u9Qzbg
	 HnV1NoaKYjxJEnaitq1ENKcgUOFBQ3oxQesIe4H+OH1pj4PmzHbz9LTxR71GB8RPDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkODUEqk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAB606A31C;
	Tue, 10 Nov 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkODUEqk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2931F0089F;
	Tue, 10 Nov 2026 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329079;
	bh=8/qfX2R+fE5TFU8gL1lYbWbnT1+3dpcnTBXBU/PkfAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SkODUEqkvlyRvjcJwC5tU5BtqWCLFI5gGvgOPIh2pyDmhkOdp/P/T5DOaOp25rRUJ
	 vO+TIZGOcCm/WHRu9EEVtaII891yWB5GQ0VQmiX+taYdFzXLQtYBUdKSqBqOuktSmh
	 GvKIdZFVmH5iBQAWt5dQC3Qmmx8Wb345AfHpR/Y+0c+iNKca/ey6QlAnjxQ0QVMMcT
	 y8Cddppsk6vxAy0cJZL0TZ9AdCD/mNiWC1VHwhPdksGr56t4kprZxbf9TC/0oPZ2cc
	 HfoScmF1jA13vzAW+bzN5kbXosGepqZt+NnybIWXuZwyXGD9z6qweyIGN22iUGdgfs
	 S7Kxs08xIWFPg==
Date: Tue, 10 Nov 2026 16:44:37 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/11] zsmalloc: encode 1-based obj_idx so valid obj
 is never 0
Message-ID: <avNJ0p1v6FZ-wnQE@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-9-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110054836.1515030-9-senozhatsky@chromium.org>

On Tue, Nov 10, 2026 at 02:48:13PM +0900, Sergey Senozhatsky wrote:
> The next patch embeds struct zs_handle into zram and zswap entries,
> and a handle is considered allocated when its obj is not 0.  But obj
> can be 0: object 0 of a zspage whose first page is PFN 0 encodes to
> 0, and some platforms do give PFN 0 to the page allocator.
> 
> Store obj_idx + 1 in obj, so that a valid obj is never 0, and adjust
> ZS_MIN_ALLOC_SIZE so that the largest index still fits.  Unlike a
> separate tag bit, this doesn't take any bits from obj.  zsmalloc did
> the same before handles moved to handle_cachep, see
> commit 67296874eb1c ("staging: zsmalloc: Ensure handle is never 0 on
> success").
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 3a6a7253fd01..aa436df0cc4d 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -61,7 +61,8 @@
>   * Object location (<PFN>, <obj_idx>) is encoded as
>   * a single (unsigned long) handle value.
>   *
> - * Note that object index <obj_idx> starts from 0.
> + * Note that object index <obj_idx> starts from 0, and is encoded as
> + * <obj_idx> + 1 so that a valid encoded obj value is never 0.

Well, this may be a stupid question, but why not make obj_idx start at
1?
