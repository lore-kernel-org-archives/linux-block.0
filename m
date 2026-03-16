Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7733ADA2
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657509; cv=none; b=UKkKxS222Pmpg6rIUJFZYVosR2sj3ZJl7geAMDHv4nlahqH4b5Exw79G8CBSBgbMcSd6/HYGJSx+wwR6JlLqZwS2ykYJtRshqWF/URHLRNTBcNEhwDm0Q9N2G5NWYJD3FektwE2SYNIbjRMpuRi/kU/+YngArbxF7VBxDwV0n6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657509; c=relaxed/simple;
	bh=fdiOOmRC9/5MjW+e4V2P6aKLh4fLwMKxCk4R6QAyyug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzj5N274vi2ArWx/yiIomxa2aIwEYTzcVCSSYQtQ3NaJir2fhZqeOx3RPqyZo7MgZjToYx+sYJGQnRKadh38i+cKsr5RXLzID3Ga0eHDf3CNOp+5Siad9L/HibNUHvyfvN2T2qTEPS5vxWBmawlboYAs0VAOgPyjXv557/xIc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEMKBsWs; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEMKBsWs"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso55078235e9.1
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773657506; x=1774262306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SXYFbMaZyd4uq2jz5cd/WSU7rtMrzbFvz22tvMMpB8=;
        b=iEMKBsWsTUww246c8LavovqYfT51eSnwmd9ei8qafk9VkFx9f/N8SRfq1JDU+MdGO9
         uU99kDM02dtv0NQCvXN+qYwNs6YFKXb3t30zrUnlggLOp8j4DPrdME/9j0iejrDTJbFO
         7+q2BHA4+UpbqV7dA++nbwSHCkSgTlV+FVFsNNasLDI+RXP87yu4QGaotdL57rdFCNCk
         TakWOx5kl7zcVSg8Dk+n8h53P40jyJxThQM68ACIN0bgpDmMOpfKICQViCp0p1i/fuIv
         kFBCtbAMoK2fLEFoSmqVSpC/CRE7+zXVC3YhHVYOkv2xBrN2KJyH2HnJusQ8ZIUjD13B
         0+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657506; x=1774262306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SXYFbMaZyd4uq2jz5cd/WSU7rtMrzbFvz22tvMMpB8=;
        b=XWl1Yqs/3aCADMZ6WxJeAMpJnBYAEve9de4QaDn2GL54OmNJcNQ0bCQAzlPZmC2+GM
         2lt7F8GxGpBNLfcI2RAcNp+3r+p5nlLJel159/wRcpEjwfl4MGIlQq4Zs2lq31WWB0eN
         vk1yqMlk4aKS+DYdU20T8OIv7A7jWtNLVlCIRYKOJ8yHFeGC205B+3huLNRDLRtlWkID
         0BpwRElpGKVXFljlJqk38v1z0fD8XwB1SeDCFXux3/diTtKiEdnIO9opM7EnX/+ZlHsP
         BUOxNOsc4/M6TaYspDWqxQyrL8FY+hi/DJIErcdOdOt8d0KmC28HB6SsezWNFSvOs2xa
         /UGg==
X-Forwarded-Encrypted: i=1; AJvYcCUG9X2m4ZxEDu/ORsEAJ3yIWafXnr6F/BJ6TMPXfe83+7FIapPDRZyv17Yl8qjo3yKttnc9FF9ss46eXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVAUfDcUU5anFIubr6QWTEIAwQUPulNxxhVvfrOcnEMUeltUU
	zB35Z5NqTpJ30TWvCpNG+mF1OTlsN5ycDRcj3YLeN22FuqTtHSE2TdAY5Y3NwOAOIqhrCY2SELz
	ewJ0bEuGbUJgTkI2H8Q==
X-Received: from wmco2.prod.google.com ([2002:a05:600c:a302:b0:485:3b4c:3e34])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a39e:b0:485:3ca4:4ef4 with SMTP id 5b1f17b1804b1-485566d6ffdmr140263405e9.9.1773657506198;
 Mon, 16 Mar 2026 03:38:26 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:38:25 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-13-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-13-de9a7af4b469@kernel.org>
Message-ID: <abfdofUwfh---inT@google.com>
Subject: Re: [PATCH 13/79] block: rnull: add memory backing
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 12:35:00AM +0100, Andreas Hindborg wrote:
> Add memory backing to the rust null block driver. This implementation will
> always allocate a page on write, even though a page backing the written
> sector is already allocated, in which case the page will be released again.
> A later patch will fix this inefficiency.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Same comment as elsewhere about parsing booleans with kstrtobool.

> +type TreeNode = Owned<SafePage>;
> +type Tree = XArray<TreeNode>;
> +
> +#[pin_data]
>  struct QueueData {
> +    #[pin]
> +    tree: Tree,

Why this type alias? Seems cleaner to just say

	struct QueueData {
	    #[pin]
	    tree: XArray<TreeNode>,

Alice
