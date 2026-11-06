Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976539;
	b=Y8W/duuOwUT3ufc4nIK06MasxacbmF9uGJGMtF16ndSFsqO6ZGLc59MiwWkTSzPuV1Ku
	 dvqcXBT1qstoU76nn3zE5Rx656v2CmBnS5QFTeB0f3hj58Mca/JokehpDkShMemnX3yXT
	 9haYroJ0a+LqgTmypIJof/sxYKG0WpwckdQxtlRH62E2ewl+p8T/Q1oy7AeQr7A6VMAM3
	 Fv+rnLWqkZWouPIIId2L6CKcIU65BE4+Hnb2zeFX4tLNnKBCUpfXMdpAOaCZbV0uzx1YH
	 mZf5pO9JgrYNEXsYe0PY4kQOeMJ14elh3RTZwNxtxGYvx2Lni8913876v72YP7YD01g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KmBUd9exzk7mgN4IOC0euSWsN74BamsE8FTjSoZz/1w=;
	b=x4z5QChVdwKZl3BuswwJk3EYSsvVo2hC7MH6ZyUwViG8c3yxL9j9VaDQfrZEeIT8tArj
	 5BF0KY4VJiGMKcB8rjkKTiCuIiEn8J3jscKqdN771mCwusv1QJxP+vvOJZXTTTxrEZ0jC
	 28IoRL1Z6eWnnjTU5cUkqVr05RDZh+hnQEv2foMm67XpbEq2JR+fpo4h4C8QC4P0AvTPH
	 HJhGYQbja2/ftDQB17Ipd8SISWIjzS4nO8WAJcE/1KHoVoSu3e6dxnwsGrhWn3RAqI5Od
	 ynUFViKksYSUED1tvmytk8DqQkk8vcib3WbVvM45zqBJ2oD7nh6HYAh+NFCudcNWp4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nI/43n0C";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CE606A329
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 14:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B90CE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nI/43n0C
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so1335560c88.0
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976538; x=1794581338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmBUd9exzk7mgN4IOC0euSWsN74BamsE8FTjSoZz/1w=;
        b=nI/43n0C+rFZwHbfKiP50Gu300gQvTOeFIWjKqmN34VnX/JLU7Li8hqalh4NUxLjsM
         oIxmexytObScGVnUv6DB0KjflvOIYxXL/EYoMMziP2EHLhP+GbFHLVh2FckeqZqrzk9I
         6eMzsSxLhaFSe1f98VDrI/NZRk18wB8os3kDtC9WypwpDkb00pRyc19a86Hjezhf0smo
         sc3kGMhfiny29tG8v9nCo0NewknL8C0QP17LkjKIr5MJpkdhQ4Ht6rkZ1ueJ9OjdMogH
         hvrRN9h0/2iboJrOuyYesanUF1huR9rbhPAsCRGmWDifgKQi1ZONLLODvHmTpbrF+mWG
         xCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976538; x=1794581338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmBUd9exzk7mgN4IOC0euSWsN74BamsE8FTjSoZz/1w=;
        b=ZPJxCOpf4QK3SZOIOHGarcRvoi6gfkMN9Z8sz1ecWsumaIAfAF6TNWa+aglbu9K7pH
         sXqNUIY9XbHgH+mCLbKrD5yDOinERfTpPCFBqdgPwCD7zbw6JVA4kEns8F2bLsZLP3UR
         rIPKO2bC9kkmR5TKAlEmKYyJIxSGH8VzQaLHrIoZkoOhEi7Re7Ndw8NETGh6yzhjMfWe
         M8sVRWL/vYrBlKW8zdknTxQ1BLf6SOdcg3a9FvSbWWNnDw+Gtl+kAopQDMG4rGWPQ3Vy
         khc4cznd7+44vG8Ny8lBlAvw7cixHWSM8Q+BlTJemNoyg+rLTFvdfX7+rBcMlYQjE5TC
         zJTA==
X-Forwarded-Encrypted: i=1; AKwUvBzv8AFiJ9LRTGGxVXqTqcvNJvdmG+TKeM1bH7nahe0ochbmo3earFF0YX859o2K913CkfVqcxJ3wQHPeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8SBkHciYl7uEnJcNXWhXqhOcT0VTmYUnBwCaXiwL8h1RXh0nuo
	/YzjPQjtpczXyotmdFov5EJPXO1Ny0fSyaC0H0Aosm4Dqo+6KNPskDGL
X-Gm-Gg: AYBFou2Y6dnoznz01XpEkdIJn9uiOG64xTu60yK0HMGAtzgklq9JiDH6RoHXIpAGvnL
	PPJKl8cEGYKOmpYMjHEYeXCCpaEzjvrwyh17Fnqp/mWHRirs+xYYIXkDBHTgnGUExJn2JplqHqM
	EXmYDPLD2cdzXWntcs4dlh3d57/bMQVyp4NtT1GVxxqm3jWXnXJMDrxoQpHu5qlp6Ge8OvDzki1
	xWr1xQXhRdGhPQvc1vleH33bOTGAkmkNlvA4COHmdjd9ou5vDocQ1v8iysOctIwRIqFoZ4J6mDf
	pdOfKqG6+wMPeGb2vpgE5UAWnlLcCShnFXHFCiaWO7D+lFxtlIZDKTZOc46o2WJp3JQBerz/lE+
	i6skdhEgv0gP+axQJJTVwYsq1pjiunaNBQouhoWd4y/WPeEwTxf6rFzGh8veCCuNeS5DN0Tymv8
	UgYXod0vl1kYDTSwYV3M/SrYr/qTXFHsJEcpRgPXDeEzQWHJDJ2NeJtAZkqNU4CH4JgLk7Bbfyp
	UfIbTi3kuw+YA6EjneVG1i01eVjwIsMyI89jWCs85t3GUr3GpOD2qzIHYipxVKhSsoAtLaVXTmE
	gsTfA5zSEEEAYyshxGFe7w15xfEi/psH71YRrVU2L8qWTDck/VxDldX4Ll5HOtn3ISxjRVENtus
	prCgV5Bwb5/0BAcAPY8H8pCSi7pfJM5wfaatCSvBl2Udb6ycMM8wzJw==
X-Received: by 2002:a05:701b:4542:20b0:17f:7280:1332 with SMTP id a92af1059eb24-1b25d3303bamr3329207c88.40.1793976537298;
        Fri, 06 Nov 2026 06:48:57 -0800 (PST)
Received: from fedora-laptop ([120.229.31.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4879adsm7528337c88.6.2026.11.06.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:48:56 -0800 (PST)
Date: Fri, 6 Nov 2026 08:48:52 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: socketpair@gmail.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ublk: publish a new device by its id only once it is
 set up
Message-ID: <au3o1OB1vxt1fJ-1@fedora-laptop>
References: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
 <20261105-ublk-del-gendisk-hang-v1-1-913a91a4314d@gmail.com>
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
In-Reply-To: <20261105-ublk-del-gendisk-hang-v1-1-913a91a4314d@gmail.com>

On Thu, Nov 05, 2026 at 12:25:05AM +0500, Mark Korenberg via B4 Relay wrote:
> From: Mark Korenberg <socketpair@gmail.com>
> 
> ADD_DEV stores the device in ublk_index_idr when it allocates the id,
> and control commands find it there as soon as ublk_add_chdev() has
> initialized its struct device, before the char device is added. If
> dev_set_name() or cdev_device_add() then fails, ublk_add_chdev() drops
> the initial reference to free the device. A DEL_DEV that found the
> device meanwhile waits for ublk_ctl_mutex, then calls ublk_remove():
> cdev_device_del() of a device that was never added, and a second put of
> the initial reference, which frees the device under the callers still
> holding references.
> 
> Reserve the id with a NULL entry, which idr_find() and the idr iterators
> skip, and store the device once ublk_add_chdev() succeeded.
> 
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Mark Korenberg <socketpair@gmail.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
