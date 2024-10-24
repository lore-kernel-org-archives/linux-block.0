Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893416F271
	for <linux-block@vger.kernel.org>; Thu, 24 Oct 2024 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750430; cv=none; b=ZM4NynNVj08Sw0idq78+5smn9wxO4TSRL0DrBi16ctRkURtFjZjRAxbtoA9ALpV2oQ5/4aKXXFXEmFypauzIdw+VWpCod1yofpfFAKaMk5MwfEjUb8JoNtCPsslXrW4g4yPBF0gNlk9erclT8bVTduxuFx00LH6EI3OLvoDckmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750430; c=relaxed/simple;
	bh=IgnmH2zlhXj7D09v/j5kD4MyGBPkUvzJ16VV1zTqzog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icAnuhh3TeyD+VEyNsAWyuflQUnsUKsA5BEasUvyFTGqWYOemtCJm2t2qyg8H0EUde3YyYeiTk/cQHrgFAkpH9MXSNxC4TEqTOwzpBG8iLsni9bDUv0FciXFBVA5sMKtAfWFU0LiuvjCfFKQHmDqhUhN4VA1Ho3GUNb3JqOE958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gaBKK8zF; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gaBKK8zF"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-6e35bf59cf6so16501017b3.0
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729750427; x=1730355227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dm/MIEPBZZEOTofpGdxuDln2Sbwtj9Q1T0/qRWDHTc0=;
        b=gaBKK8zFYRXDzScGu8qlyEb2q6qPicPUyzAmDe51xBuDbQ8enAl7/xeVo/P2VCqh4L
         YjXBMvEzier6cND2M5RVzIBArxV65DPMgLUGIcWIweTNElwGrmV+cgWiPZ0Zx1StAmpf
         x7uo6skYH6ffLib06bOVKnlr5LjLJeeG8TAMbk1JhFcIj5u/jD1cGE4pXqTnfiZhTHex
         WO3GL01bSurFeA7OA/URXbP1/8wiQNaLHkRIlRihPjhcyfSLlZSsASV5bQk9ht71NZ6o
         NROmO1iBVo2l2n9cTIsJbUczq6lUXNewv9t8BMC75fMhD7jgRnLNuSbR//+HE0fUuGOx
         GAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750427; x=1730355227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm/MIEPBZZEOTofpGdxuDln2Sbwtj9Q1T0/qRWDHTc0=;
        b=WXkDBkePRvZhZekB5/g/fCSnayc2hN4RflMFWpuj2X40unfA54Jx5U/asEkCLDrw47
         43vhaqyudSxyP04Hwu0fEn9+Gqu7kSG1vKbx57q5cuKiAcpnZeY/1qTfYUKuBiUxNeY8
         hXWd7+PBuX+JnvKx4JArSnL4CgPTbKh96Gbvz+GRNsOvnESkCP/AoeX75Wv5eZZjM/y7
         4klRZHXmvAnpBAdKnRJeVueQz6jwM/jKLMDlsPH1cTyhv3PKAK3cPaddKKeWR/hItyJn
         +4slw7m7FWregDEdqqom2P8Qn2GLmxiWyUFK7JN7pvkgD5p3Kc36ZE24r7V65Jgtn3dO
         xtVA==
X-Forwarded-Encrypted: i=1; AJvYcCWeB7ocVWH9kra9WkK3sFithHQR+kaB+H8ckuo5E8t6LTyzqJV8pkiLiH08ITTIg4NFdfEmFMd3LRQXHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhqVJHNhJTFk9XZhgWwkGsFmh3ubsJdt55VYoSqVJ/huxXosxI
	N+zeSTQ284sDdatHbEqTtVk2CTyASVthbewmkQiByHDB32a5v0qAAT2fXL4b8+o/XmuEVgickwn
	brriOpqYv7tEleFh3OlqKxIHpJaHGZMol
X-Google-Smtp-Source: AGHT+IEhyEKaFLcwxKzb9qz5fWduhegmFNqG9YQNEHkxE03Rz8LClOBW2B9+P/2B9IZUzvBsvOtnFWept6qx
X-Received: by 2002:a05:690c:2c8c:b0:6e5:2adf:d584 with SMTP id 00721157ae682-6e84df79fc6mr5430387b3.14.1729750426835;
        Wed, 23 Oct 2024 23:13:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6e5f5a81ab3sm3805517b3.39.2024.10.23.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:13:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 069DE34040D;
	Thu, 24 Oct 2024 00:13:45 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E3D57E40391; Thu, 24 Oct 2024 00:13:44 -0600 (MDT)
Date: Thu, 24 Oct 2024 00:13:44 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH V7 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_KBUF
Message-ID: <ZxnlmNGYWz+AikvV@dev-ushankar.dev.purestorage.com>
References: <20241012085330.2540955-1-ming.lei@redhat.com>
 <20241012085330.2540955-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012085330.2540955-6-ming.lei@redhat.com>

On Sat, Oct 12, 2024 at 04:53:25PM +0800, Ming Lei wrote:
> +int io_import_group_kbuf(struct io_kiocb *req, unsigned long buf_off,
> +		unsigned int len, int dir, struct iov_iter *iter)
> +{
> +	struct io_kiocb *lead = req->grp_link;

This works since grp_link and grp_leader are in a union together, but
this should really be req->grp_leader, right?

