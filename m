Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AC2BE7DD
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414838; cv=none; b=tphVHBvEnoNW7dRgkK+Y12I8dALuAksQ84h1078gJIrZp5BFaYvNN3FSE2xaupGJGe7HRugQIfRZFOHmY1jg5mRjrK6rUmhC+cKJw0xK2kkMjWg3nXKMuMqNR2gVAHbRDvz0QMjTS0LX/BVlnKrhftOQC6IWkhSibx7TBsYC8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414838; c=relaxed/simple;
	bh=HVgnvceNEKk0s8v4dbVy+vGP+OYmTv6oSZm5F/qvmhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmVB1L6ONmaASS6rRL5grh5J/qAIqmrRSHzOvPB5UcubvPR8rwiWD21stHQmHlhRZ5ttrGYWV0BA/P5XOwm/MrdOiwO6CrBEgfwVLlMqGtx6lW+HItxEvFbYl8rye7jaVeDf7w1MkUDPllBqJ+EQ9tD4hAqow7KieWjKGW2rMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy1QI1gI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy1QI1gI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5165195c8b0so75705731cf.0
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 18:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779414836; x=1780019636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gw9SBzb8I9Zov+lx6aM52ecIi9qtL1D16HuqASE3kU=;
        b=Cy1QI1gIyBaUvBuDVizgM6KBlMVXOF3fw/xxWIu8SmIS2bpy8zibnqd40ve5JbWIDm
         nNhtNFZLMAQgpV2wvj2GxKR469nR1mi7MVY7z4CzPYyW/C0Mf/Khyloj/I1hnJiu6w+N
         KGMm0xTI+hBrffLjdJ3M/Kbbd64qh3iEzsm6zjp8kHNDYWj/X8N1moViTwF5FJ5TWpKX
         fkxGCeO/fV15WD8EUx+pN3ALhi7+bh4JHoQCxfX93ldL3ZpWVj9638IzM50eazjY/A+m
         J/T3wAay/b2gyjqQ6npNKarhvnHFV3mWHuDz7tV6rJaBEwdCWMWSPvOG9Wrb/qGQ2jiB
         cqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779414836; x=1780019636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gw9SBzb8I9Zov+lx6aM52ecIi9qtL1D16HuqASE3kU=;
        b=UL+GKf5fk2ErpQ3ZZSi85KWrXO301nxOeJ/j8wFG7m9IcjqT+i/Ryvnj6IaJb/nQsk
         FiXteuwEPjNJdjyKucv4w8zMfEgGIYzMoca5FWGe2j5bQQ6jcQ6fB44QvKSqrxHanUMT
         5S2XSk4uPeR9rtSzW6xJ0bUDVyJiJ7IJ6BvSps1YsRQzFZMmhSDBMFzKPjavp2oQ5GJh
         5xin0pTbKc7N0laTyp7b1YjIj3y6gmurKE5OVobizieKL/vwHz3piDQDhWPOHbLIy8CD
         Y3VlL4Ju8Puij+Kt3q7hO0A5eOfMZLVQxba7K0x/VmZnLD8IvckMUkhfoZvtPfZxVTla
         qMjw==
X-Forwarded-Encrypted: i=1; AFNElJ/YyEzI8Q+tS3jvV0efvPn5ltUYy0lNpg5IgQyl/qyEpD1W1V9qQI9EErG7tjldDDk5tIMuDZecw9m4fA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTs9Vd6th1ioldF2Usuct2ZJawH/TPJAeRUeFZdSrOjz7CXzN
	TXqP8nyIBsrqvQ3WPulkE3ecuJ8nNw27fI4SrhdGXYjjOw59NFQIZYIN
X-Gm-Gg: Acq92OFFYLwXOiORRrmw6OG4eGQCJ8W5dzkvTqmzzlHi8T7AHi0RKjIhdVCbCISnstL
	cByl6KqDFUfPxe6LamKON82PnWZkG1t1F7WOXPgVIRP1ViTqiYSP2j6BFB+Xp9zimrMM+OtM/PT
	xQ+zQe6hqGKxboqIkayhDfN8h+mw38Jrli7lA/vaTxswGGFZdVkWQkr9+/sg1QqXKLJm4DezDWg
	46a2CxMHdvM2Qdq8GJzpTTjYUdC2A+bm86D9u+JUKuSjF9cjeDRk6aMpTkj/l3waYLn8B6rEw6U
	QlLPy0b/dJ9FVvCpUWwDMiINVI1ZmKJdvlK778gAH4tsNRr+uMSVs+TCHVgOZnJfmqVj8pT+q8D
	idM01HAB4FcscyeQ3I26cFMMVciECglPGgpfaIJuR9hITlHzXKZQtMQV6/aWdhOfhRixFyrfujn
	+aaDZlJdlJtTu7H7N6ARV1OD0rbFkLcltoRzX+jJrw+XAmH+9rek7CcJV8CihMGKZ39dZoOOeLF
	NsgnaIalXUA+c/D8J8q
X-Received: by 2002:a05:622a:5a9a:b0:50d:9b07:9c44 with SMTP id d75a77b69052e-516d459c83emr25573561cf.39.1779414835747;
        Thu, 21 May 2026 18:53:55 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b25c69sm1304651cf.11.2026.05.21.18.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 18:53:55 -0700 (PDT)
Date: Fri, 22 May 2026 09:53:49 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.2 0/2] ublk: enable UBLK_F_SHMEM_ZC on zone appends
Message-ID: <ag-3LQ0j-AhGCvsh@fedora>
References: <20260520203654.1413640-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520203654.1413640-1-csander@purestorage.com>

On Wed, May 20, 2026 at 02:36:52PM -0600, Caleb Sander Mateos wrote:
> Commit 4d4a512a1f87 ("ublk: add PFN-based buffer matching in I/O path")
> added support to ublk_setup_iod() for matching request buffers against
> registered UBLK_F_SHMEM_ZC buffers, but missed adding it to
> ublk_setup_iod_zoned() for zoned requests. ublk_setup_iod_zoned()
> duplicates the code for initializing struct ublksrv_io_desc, making it
> easy to forget to keep them in sync. Move the common code to a helper
> function ublk_init_iod(). This allows zone appends to leverage the
> shared memory zero copy optimization.
> 
> This series is based on "ublk: optimize ublk_rq_has_data()" [1]
> 
> [1]: https://lore.kernel.org/linux-block/20260513211846.1956810-1-csander@purestorage.com/

Looks fine, it just allows the optimization for zone append.

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
