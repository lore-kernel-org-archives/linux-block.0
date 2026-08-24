Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77A3F0744
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562360; cv=pass; b=LjApZgR80PxegrKjWJtBVeR6c6FnZrdq2s07piJVxqGyuBrXymDwVXjrTXXQKmhxjgNe7ADbNa544nibKGkKMjGgay+ScNB3yjwSc1ojr6Kc9ev8m49otPU6N+SGQZrrnmKOUkM+XLsFMnXsH5UmeuWkk8LUYBlRzfEQxXIwHP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562360; c=relaxed/simple;
	bh=k1VcahloVqTMd2bS2EdontwtzK2WJK0zze95i6TSOFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDi8qLm8WzK/Iziw9JQMZxXQs43JuxV9lvt9vxen3hYnyD5w/MxT5juW30Ur2hGvsSYbRcOwooRDq/DHdY9Qmy56C4RhBUlc8XZzSBYZZ00X/dHXu4B6VrAVWvZsqvY2GK1GGRIsnrq0jxsXfQNxhEspWizHo05DtJOxiND7xPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Md3V02RB; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Md3V02RB"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93695893ac1so185709285a.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 02:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787562358; cv=none;
        d=google.com; s=arc-20260327;
        b=RBTbKbxgyLJBjDkNZRJGTd53IurGqHnbf9yq5qfmuNeQIVxxTc8AiVYV9/mKhZeaPN
         KMFpjCwvm3tWIeezhw9bZb45RwuiLzA2qu/sv0AQsMVtleVC/2xjU4OX+Ly5wE+nM6E6
         fLwD573FMLbtPFUwG/8f2YlYpTECF+2mP5pCrUFXELAjGG89rz7779/vnXEXG31Dk9Hq
         Ln5omNNFHaNa9RedDgGvz36/LrqYzSHoFFaa8IZYxr9R8s03TdYcGXkRjEk71oHxatoE
         CJinvaSAGD1jOFkXT7UC2pcx/5fxji+1wsAJoWZ/oV8Y0nmbpXt6NCshCqPS2tL3CUAe
         V/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xjSchm007/sw+2JfMjG96f8T6RE12rgCCudebYixRu4=;
        fh=5KsOmBQBFC8XHgZCFZkHSmUai/13mtTPPh17I3CqZ00=;
        b=AMphCQf/d0M4qH1Ess+ybDx79x3E+YrR2OWUXerj/7Mrk9S1Zqa9+RP7wwHaAF4NhD
         I6IM8iEpXXcjhsQHShC8i/N4JRFYgIcdPbVMJ+Lzxs95nnanz+eWRdUpZ0gaCLoy+93R
         qAx/OtvtBTHgAt+TqSZ7/B7bZDxdpAi6cAtQKFf5U09JVLJcbkwFebxoC/jXYuhmaOXE
         reSlQVuzvsqMfxC6+TsTzGTshLtnQjxkC5anqQmFVc+C2TQGLrVGycwg5NcwcrFC1Sk/
         Tnzuz+bB46Bg6AMw6c3lW96xhAnnGZaZQbQkUK/9Qs0i5p4cZFA7yFDSju+7eis3eoE3
         zZ2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787562358; x=1788167158; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xjSchm007/sw+2JfMjG96f8T6RE12rgCCudebYixRu4=;
        b=Md3V02RBMrXT7++lZjkapZopD8qkdAFSHpNsSv6QmBIPKOdzQWCNN6AR4kmpFvkadv
         0WjoUBO4KWY/LQLlyBAjyM8JJ34zje3REjajNVZ3Gow34PJ4FI1D/qOFI4wkzef/51KP
         WjSj07LC1JS0zXh2vxVUSAXHu2k8KyBR3WWNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787562358; x=1788167158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xjSchm007/sw+2JfMjG96f8T6RE12rgCCudebYixRu4=;
        b=a3aY0EJvqkV89g9YUtyF68oxT3qAOLwOM9+YVsVeVd/Cw4HM5uI5rSbbLEzCK30jsC
         iSJqrt+ldl8Js57N+rn7RwA9a/xbsGACp1wiPOGwuedFo5DbcqOitZsZ+B2TnNLbgGAd
         4cA/Av0qTOH6fHszdR+6Gjv7DgoQtSQhQ5RZPKQjNgxBm//n6ZatDv+TiE2TfBIJ77tX
         DQS8z01VUqAdL8zw8dlob0tj1fmEcurf4NGIrailb4o7kpipkDWhGpwd+VSEzb0pDjG/
         ptZnYWQuIS8Su8Oq5NzofCTDWJ4tceC0zHKac7J8O/NfRVHRF9Y5dhPtfY0zIBxwgXby
         nsrg==
X-Forwarded-Encrypted: i=1; AHgh+RpwOx5MSIBtVwU8qedouXvg+U1Bm2oj1GnnDHYBg8Fqt6TfgA/OS13HoH+Fi7i3mAX9+Ax4Zqh4WKXm1A==@vger.kernel.org
X-Gm-Message-State: AFuF++mM0rGcHdkb2r+x8SZnD/bHT5cjL5Tb39qBWeC6dYhKFnDbBU+S
	J0MCemX3RrIR7cWhD0RmPpD8h1IMXt09IUlOBJwovWgbOUe/NjC03YizvxywXhyM18yLUP0yMCl
	g16PFo5wMol0JHJKBsdS65bbnbdH/f0MI+8hjWlZCNA==
X-Gm-Gg: AR+sD12an1kxhj96varWq8FZ+KRuxKHu/qX/jHM4rCNGLNlPOyYdkw+7YEbuKYwitlE
	kuJRnlUxFD5faubE/RhIUB9uN9/TD0l94fEzP6DGDYqA12kCMmEO+JNc0ICofqEr4ZZsWOMGTsE
	v3N9Mh6QqH2NqwYS5lsxFWmivDAy/fNSmg0gGpuV8Nm/3GXrhBouj5XO3R4t/fIqjsvlFsHT5sT
	MNqmbOJLX5AmWt13ytmWEbvGKfyEoKQtReM1YDAsMNdSlz6ulbw830R6x5POKSGWsqta7DEL08b
	ScVY/O0MuQf6iZwbKKMoMPbI/THetlushlyV3wk275OHDqgf1b9WOnlfrQLSMRDp3RW83GsDyF4
	vOSg=
X-Received: by 2002:a05:620a:a2c6:10b0:92e:bbd0:260c with SMTP id
 af79cd13be357-9373957655amr1668397485a.36.1787562358062; Mon, 24 Aug 2026
 02:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
In-Reply-To: <20260820193343.3852967-3-willy@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 11:05:46 +0200
X-Gm-Features: AcwNN1VnwXUZIDZ1PfaZZEyLrhKwB3yAlvrDYfoxcRnFp4RHIk-2JE_xMlB98T0
Message-ID: <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Aug 2026 at 21:34, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> FUSE relies on invalidate_inode_pages2() / invalidate_inode_pages2_range()
> doing writeback by calling fuse_launder_folio().  While this works, it
> is inefficient as each page is written back and waited for individually.
> Far better to call filemap_invalidate_pages() which will do a bulk write
> first, then remove the page cache.

filemap_invalidate_page() suggests to use invalidate_lock to prevent
races with pages coming back.  I'm not sure that without it the
behavior is identical.

Maybe add a variant that takes that lock?

Thanks,
Miklos
