Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570A42E414
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579395; cv=pass; b=G/0vzn0/PP1KxUtKJ8NL4Hu8nDpeC9BMeUH16LuIMbX2RUsgP6wvm6J65dp2kuIvFpRS5WezhqzOX+/OUMOdRZ5v5QCa7JlEVpuhM1wyHCBWtWkX+m2qnsSvxyHEAYnyvXSfUaNeJHUtKw4jCRBaH1XHtyYq4vHn/jiUiqbo0sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579395; c=relaxed/simple;
	bh=Gdi0w031Cj+0ZM8jnslnu596yibLYY4OhKTpyU6L/3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBAudtPsquBjmlmrT2iyKWIXcC3FUaLzZRh5AtiGAHayt8/B6Arm+ufmgKlCfmKiXHmjprzy5OxQvENg27+5QtYf21uaIBfVinLfdBiDCk5xlAfDxcBe3LvUkZL7bBEJkW8FM93Y+8dWwZIMe9ZXrVG8GUpzEp5ORuSmPaFqKc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NDMoFzvQ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NDMoFzvQ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517dc520840so25202641cf.3
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 06:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787579392; cv=none;
        d=google.com; s=arc-20260327;
        b=Z7Bi6nctTiE8NGKhFhlCznDAL3p63rY0mXEPt71MkATlyXch7kcFku17Oc3/e48+Qe
         9TvduB+X1pTk0Y0Ci95HO+WhrvVcg3xzFCxjyMZ0lnh2SA76eWcL+T3FfmVulZGsbv2i
         prjvfR9dKiSMZE5PO+SeR066NyAlDvlgAZDXui4lH6Ok2kRbnz+TkgnSiQp3eZTR6y/W
         +pnFrrI0qsOTi6dCIw5LrWWzFNXaRLk0BzHRntb1/VTPhFxA+8I+mQ9gUd1GQfxKAC4J
         64iTzrG09CD4j9Z3lqsmaH5A5ELzydao/gANyVtcqIXhqylNMZY1knXpKi8RTzpgMYlQ
         0Idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UWqjXIcqtIZGoXJHhXghNNIDKwEBlEpB/YPKWMii0qs=;
        fh=nhaWZ7LDv3kLkksGRuBoIa5owzfdcgENBNnw9CzNXIg=;
        b=DBL4yS4H/Md2Q4/pZy14eU7eoOsxgM6bSXVcY2Pi8Ae3SoB4lxtnoCDUUWg+rS48CJ
         rmI863QBT4b5HlKyn7VZOwfEXlc6pEwczCg795AWrwcS1slgXktOBfROh36qF+GboHtp
         fQqwEzyH8rXI1+7zfKxSqQnibN1lYjU923/mlfJ1RQXVG7yIsBC20XXnkTexbVXSNbt3
         /OMCedz/qiNBUSi7oenmEnSSkmhgmIMtFKQLfPDU0IbBG0Mpd2kAK3AWR/+jVb2SLjzn
         M52G1ASz1T/155Qvqxg0/M+bzQV7wCRHy8jrKpMIJ4Nd3S2qcbyZT0x9f954GYNS+s+Q
         Au3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787579392; x=1788184192; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWqjXIcqtIZGoXJHhXghNNIDKwEBlEpB/YPKWMii0qs=;
        b=NDMoFzvQZiYLhYfgLRj1Ktm3K7LltETOkninXMRKeKJsVGrX/f5yYwoKebcqW5zE+J
         Nuh6crj5oNcOPXEhNSWgsZDXUjnF55flY4e2grH5zeQSUf+xTlynxncJqIWBpEWpcJh3
         2iRMqM1j+sNOmGDXD8voA/XnGZe83Hp5BGNw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579392; x=1788184192;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UWqjXIcqtIZGoXJHhXghNNIDKwEBlEpB/YPKWMii0qs=;
        b=MGev92fcZOt/RYmtApJjr6o/VMY/AHpkOGElUucLSXTNxuyalTDs9nXRbw/mXQOY0l
         scZWgPysj/8i8vQbwV2MJPSKyfg+aB+q79jjni2P9JnAlKWq7PYpXYVlBE1Vk4WJn8F0
         uYR+zEXf5jSsOcPfU28N/uvBkkeiZZ7SMM5phRpri+W+3RSYz60iqHu29nJvZO3zSILG
         mhXKain6bGdL+ClgBDvGgfBQkynmU1ZSagxM7MGhRKvm2MKRFgKOHoRXc4E5lyNf1PMm
         zqdeONRy3SIkHShXDRMij3p+7N4Uj90CMc0ontH0Ck4yqbGL3DUeDObSUosv1v/yvELT
         aBYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFDhBM6NF0B5dYkKYf+4nGdBjBCrY49ukrl2Pv6Gc59NpIT/hLnUuZFaWUzHg+2Dk0YLNWfPWALPaTNw==@vger.kernel.org
X-Gm-Message-State: AFuF++natxl4WKERexL8e9seK1GI1V8GvJEcUtJTt4MorbPt80uNyWsp
	VzyDhLne4amHrKsTHerEOr1Kqsb+7aJPX8b+NbngMFVmxkzY5UFaWDLduPlNZiEtVBSN0q7bGNe
	RAqbfGU52wYAfpomjxVMm2mITGoa5gkQYBNjkolvVqA==
X-Gm-Gg: AR+sD12L7lBrq/p68ZCPrJu/kunkieLcHMNmfFe2b3svRmJFCYxGn7PT0g3RPYxQtg3
	eH8l4ixTLSDwQ9vUMI9fWpHPkaJl30Fi8DY69tn7aowi0e4WP8m/taHbr9EM5fpW9PMbkyfL8K+
	cEkSGrPuypkpDEQRrh2MLQel9eW/K9JcYkqKGseU7YLyn6EfPWL851ghgAgvs2F8BUOD0OzYbsq
	b48cNlcLKYQrFDLLH9Enm8OMctFR5lyG4jNkReSKScBsoPv1wmAUFMlhCdIEc9F5w2IH7/svW3S
	CGOt2ah5o4c+eA3BfI8HwgCF65/JwQDXi19CkN/AB7kIig8n5uz9sZ0k1yLVjI/sscHZyk+cToJ
	JGZk=
X-Received: by 2002:a05:622a:8416:10b0:52e:1109:8f6d with SMTP id
 d75a77b69052e-52e1109944cmr94356391cf.42.1787579392384; Mon, 24 Aug 2026
 06:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
 <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com> <aoxHOSC9kTPbKeNq@casper.infradead.org>
In-Reply-To: <aoxHOSC9kTPbKeNq@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 15:49:37 +0200
X-Gm-Features: AcwNN1WXkLYVG2Rn2OXRtnBdlHWAinn8Fn4WcEVqUKiB1DB-194nq79209afcM4
Message-ID: <CAJfpegv3Ak+qNLb=fTSCSz7-taQ3Ui-Hkmqgn4PaGPe=CR4cbQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 15:29, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 24, 2026 at 11:05:46AM +0200, Miklos Szeredi wrote:

> > Maybe add a variant that takes that lock?
>
> I don't understand what use that would be.  As soon as that function
> drops the lock, the pages could be reinstated.  If the caller needs the
> pages to not come back, it must need to hold the invalidate_lock across
> the whole operation.

invalidate_inode_pages2_range() together with launder_page guaranteed
that no dirty data remained in the cache after that call.   Yes, the
pages can be reinstated after that but those need faults and the
server can then serialize those against the invalidation.

I don't see that guarantee with the filemap_write_and_wait_range()
(with or without invalidate_lock actually) since the mapping can be
dirtied again without the filesystem's knowledge.

Am I missing something?

Thanks,
Miklos


>
> Before any filesystem people get funny ideas about closing the O_DIRECT
> race, you can't do that because you'll deadlock on doing I/O to the same
> file that you've mmaped.
