Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073331D61A3
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113618; cv=none; b=XW1Be4hQzRUkdVd1haKb9bYyxLjqCLu66Mp1BDnvSxB4GR15X0i2XTW047YqkHAuYem8xC/URZC8OV0R8wG14bvKE89ra+x78/NEhpG4IxDX4WJHXLaI7Q6zYYunr5a4ZvYJZ7NoKJF/0kTzedxEczJC8Nhd27DMGLtqcpMvNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113618; c=relaxed/simple;
	bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWPqc4kc3b0VXKcfF/gyx58B6V+21dSWd+wQ+C9wfWtSA70kDwLqBxqscCSDO9xLmn+XugWbW4XujR131iWQUYp6zexaFUi1D2rbvfomozzXAK5bhTctbDtLe2IkX6xtvF5mDBq3Ka1HiTMtolsz0M0/PS9h+byWJ7ZMmJLIgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RapJjHXY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RapJjHXY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3436a97f092so7566569a91.3
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 15:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764113616; x=1764718416; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
        b=RapJjHXYPOdTLcYLs/FvDuCH+2uk3C4YvOZho6lQ2DUunXzuffgOyrJJdJTT+zKarB
         Y5bxS7QTjTICzx73EqYjfUkyl0FVw4x9IAxmcOzG0aCf9aVAGcQLF+SDf8po/2gyqqil
         u+gb4VscO1GMmQtuJOgEikKXerndt1NLulnw2mreQGqo90I/pv4WCBVSlk7wWQqvo0fD
         8ZxKliCAngF8pEnFcZP66ohQJSs5e4FCjllfn5lHxNKjvERABRh6B4AROdQzHDTgEkH+
         MWlBTtaGwqr/gZ+ENsb+GNvzwbp76+nYbH4gEUbWlRmpDTMmG7owIjbQdwNz9RDxBy+J
         8lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764113616; x=1764718416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
        b=goFoKYmquQIvAzY0sLG0DeqMOxyv3nAP++dHMIPpfzQdWsiCJKWAJbJwU6mcDN/4ZS
         6SACE8R35ZF34sjA62UbM6XMhZXsXs1co7yJ6EhPBYj+/rFPXfAecZjeXAQ1iA5Zly4T
         1eGWhpjU8GfJgz24pYWEYx+IyxgO0qae+wK+Y94PgdtDWG4f8EBp4UB761F1TviCHlWx
         qQUlA2P0+NP2jczBDOpJ+FBI5K9zKttVe9GDikj3QTvWfsVUNCdptdpIgFpaMNezXx4H
         7fhOPlDQt3aOfWLnsz3SNIsP8acI2gAmd2Dm0VcuQxBP8nmCiAIIgWrWO8Xv3ZqHhEF4
         16EQ==
X-Gm-Message-State: AOJu0YyKO0otxo3KR/obQPnbR0kbR3wyudZ8uDTC2jIH13kHylIV6Wej
	aKbaNa4aaP5JPRWTDH20VC0N8wZte8i8sNpzG/1Hagft5cC8Gvvz0Ot/
X-Gm-Gg: ASbGnctru2Hg7A79EDDLOQqWWoOSG4wlltmsZtSrnf+WMvPK079X7ajzevh6EYTPMlR
	4kRcP6Mu7cWqy8Y2FjgJ33xHqaFCj2mtnHDo6uxjq634vRshMD6a+IjPdq8xgdZJpQgAimUpnNX
	YxN86rIbE0BZdQLKEvTsuG7xcxzo7QSNy8ktbNQ66t7uS5swvTCNY4OHR5tSpmY19i6xnTx4Iat
	rs0+c4+YvAUzcxi3xLAdY1bUbu0RMcGYLLLwrgli3GMcE0r0Zz2tCuBVjIoaX5z9JM6smqtLIGZ
	8HoiRLfVTWHM+PP+Wsnq0nOXQn6GR3vamgbrWeDh8VKl8uVKiULbvtdObG2mv7uYA4aB8BAHEUZ
	NYTRtJyXkmQ9aSn6gJAscsvTjxK+L1Nd6NaKTL9ogmP8WMQO7ozkECMRMT825lHNy+e096bqNdK
	fsx1nJam4T0frwYqoeWdoOwghi3mo=
X-Google-Smtp-Source: AGHT+IGN2yQvKPDnQSI+rfi8GFgwmIi2Dp/WjRDvh8wa+7M3RBmYm0POoYwrQhejduq1ue9sQHFv6Q==
X-Received: by 2002:a17:90b:3a4e:b0:33f:ebc2:645 with SMTP id 98e67ed59e1d1-3475ed448a0mr4374100a91.20.1764113616140;
        Tue, 25 Nov 2025 15:33:36 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ff0eae4sm1654152a91.4.2025.11.25.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:33:35 -0800 (PST)
Message-ID: <2146e663be965ee0d7ef446c7c716d1c77a8a416.camel@gmail.com>
Subject: Re: [PATCH V2 1/5] block: ignore discard return value
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, 	chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 26 Nov 2025 09:33:26 +1000
In-Reply-To: <20251124025737.203571-2-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
	 <20251124025737.203571-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Regards,
Wilfred
