Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC11202C5C
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335123; cv=none; b=PLWl5x0ZKUcEmyKdotMJGqAitR/VLszfCDZjr/QRUWWUH3s6QjCwsHKbRkj7PvfFgdYOBMtExozp62To01HeoIVM1MvJKRL+3INvXBclGX+5xDwwpTk4nnuV6ClJWRfc2v5SKTkJX219NoFz/DCKkEZ2LwHDXFSqbufW5oxfpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335123; c=relaxed/simple;
	bh=FNOlOnKPTmoDLF/ixHDn/TzCbzcrb8utOwuiWY5hpWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDJRISbVCDDeKFacV2IKXuIuerMyfNSNzy1lbmRHYaIribBhY6eS4uexvaCcM9+LEQWzi5L3jTt1lyjfwQtciI1mhZWKj1YMfvveeIQarwQCd5mk5Iv0KpKiaOJ5IQusSrmfQ9aoJ/2zCnLwxgUifJklflLmUiztziHiqzhxEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IzC14sa7; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IzC14sa7"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d44369e87aso374665ab.1
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742335120; x=1742939920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yx3ZT83Sw/P9UkLE21bhz44X65U7VubHeSIX9oQCM98=;
        b=IzC14sa7wtXAvbvaKXncFgHXF4grPE9eNuCRf//kau1C2tLvNK1lEUv/vJzooy1ZL6
         GuGX8649emGHDbC2OQOo4R6EcOY5bQ+RRs0/c7oN5JkTqU9umugdzjC4pulfGyGOoUsr
         QyPMVrcZikp6ylpwD5dOmj5j91sP46t610WzeB6/zuOdrSpz9rVn/F6M5ijKJkyDjYHy
         APQZ6VKU4xEfAkD98XtxH+DGIoIglSd913PsOWEMSeeaKHe5JfF78qT9SaJ/U1q3T+sO
         w4V/BTLyy/1pLyFV/bJtJQyLNGpHQUM7QtrGKef1apobhAXCCNAnKfbVLR+9GBbErm3G
         Rc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742335120; x=1742939920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx3ZT83Sw/P9UkLE21bhz44X65U7VubHeSIX9oQCM98=;
        b=PXfvdxeAtusYw2Xfnwvqc1LST18DNXv5AfKOhZj3SpRm9bZqUJng9BkPzDalkBqojv
         l/JNNVfIDX+MWDvkioXfw4X1OqNuJb+qEBYISUFKTLvTO9VWyGtd5amB9FLK01gYq+mM
         lzmA35t2zVqFSC509Ocs+qHspmsxlWPUxurLcFrZw6oqZ63/LobyMNvijtvJwel6MXUD
         7PbT3JMSzmgbBKpRT5C1uqQY/O2787kdBMTade6OE3rsLXMxKVFsDqIcC50pHx48OH1P
         1+3vau2LM2djV/rB8XDVSi6A0ZwSU5SnvVVzQG8mV8dAeJFMYWZb+rwBhG0WS471jvEI
         Pohg==
X-Forwarded-Encrypted: i=1; AJvYcCXKq50QNeEQNNmCBgiLvymMvn7k87tRvsrillwYOOEJj5bUe37xGCFPaCeUaMM+ZwJ24bceEloVRWutMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2KeMWvEFNksWtSYJJFEAoArm3AfkC9F02pRt2swFf34dF2pi
	Q9hg8CqtOBOrel7G6uTM7G897fUDd2CsMChgvqeYc3LKArX9KDxlOlR/cCWeQMc4IYxjGBXBd06
	gJPQudJwsQd/Qrw8qfK/P24x2YPa8j4jI
X-Gm-Gg: ASbGncse6beXYcJEAqCjxKQnjDDVZ+ttvelMfd1BMOqAS6ZjbSh6DbGglCpV5qJojEQ
	Rva0kLg7XncruMYOKAqxdXRovNTIcSsrQYrIKIyoFeUonm/9UosRMQ4J9NHIsX+ZAtlqZPFbc3W
	ozJNi74fis01rezNj3UeO3w7sXxCJ2Q2+kR9zvJPODvYLKDb35o2/cyQscegFjwN5E90sqXu8ii
	lxeN5XphHiCwsix7DMO60ISrqN66MYwU62Kz5RmmGENjYRZtiIMFwN66psog0oWK1Xedk4pj9Bh
	u0dDOcIfEXHq2SD4FLNgfSd3hnvdrxTWAAfWd6a/y9SSVGbNGw==
X-Google-Smtp-Source: AGHT+IECvniETaGhCeEpj9MhYKxcwDE74kf5vAb4l+lxw+2Z9R92wfP9az5nmgsH4mfe0p/fxsSqnM5lsGrw
X-Received: by 2002:a05:6e02:20c6:b0:3d4:6e3a:4659 with SMTP id e9e14a558f8ab-3d586dae129mr3889215ab.1.1742335120214;
        Tue, 18 Mar 2025 14:58:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d47a68593asm7574825ab.40.2025.03.18.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:58:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B42A4340338;
	Tue, 18 Mar 2025 15:58:38 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A8733E400CB; Tue, 18 Mar 2025 15:58:38 -0600 (MDT)
Date: Tue, 18 Mar 2025 15:58:38 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
Message-ID: <Z9nsjiynsQ9gRPv7@dev-ushankar.dev.purestorage.com>
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
 <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>
 <Z9m+3qMBXgqDz399@dev-ushankar.dev.purestorage.com>
 <097f0495-b2e8-4938-9a0d-c321f618d49b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097f0495-b2e8-4938-9a0d-c321f618d49b@kernel.dk>

On Tue, Mar 18, 2025 at 12:48:44PM -0600, Jens Axboe wrote:
> > though I don't see any examples of drivers using it. Would it be a bad
> > idea to try and reuse that?
> 
> We can't reuse that one, and it's not for driver use - purely internal.
> But I _think_ you could easily grab space in the union that has the hash
> and ipi_list for it. And then you could dump needing this extra data per
> request.

Another idea is to union the refcount with end_io_data, since that's
purely for the driver. But it might be a bit weird to tell drivers that
they can use either end_io/end_io_data or the refcount but not both...
not to mention it could be a nice exploit vector if drivers get it
wrong.

Either way, I think this work is follow-on material and shouldn't be
rolled into this patch.

