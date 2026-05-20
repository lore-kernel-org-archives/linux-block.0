Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC036EAAB
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263366; cv=none; b=lPNShSjSKsz3JJObvBKRN/G6pC0OcFQ2IYdq8N+CQ4wJ5cF94IfCzn19wyBKLQScxXbP2bQIwCL9vq4/cdcHtNmCN/ITzyZWTOjOArLYXAph2EccXja5IbIQKqFPQxUdUCKoLR1x9LCIiDRxwtNTG1XO2tT7QkJtJp4CPEWPkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263366; c=relaxed/simple;
	bh=jgqXvPn1b04hsZ+Hw2uONZsXDpj1NevG/uLMU/NzHFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov0arEiQYdbZuAc5Ve6sIdiWzuU0C0+Uu4Zzbu8HOIqpVKkzghfX2JykaSChxUcBZ4N6h7bLd5ak95mJcyy5lwicTzTSiDi6cEQ2UYj2H3n/ZQHfYjZGgc9ybmAcU3vjhUvC7lrPMZdsw03K3+jELY4eqNzaeoGuFRfGrYYNSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFoYbLTr; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFoYbLTr"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbca22dbfeso2314618a34.1
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779263364; x=1779868164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=poSwSX8KIzSZ2M4DpkwCMfU4O5+/PFhY4YD5GkdZ4U4=;
        b=jFoYbLTrLheu39ao2JhgbtTi6kY+k8CDzqnDzo8ZH+rnjvGHGjOD1oX0JrtrKEv1Fi
         WhJT/KrIoAAeVrzI9935AaDPyzAH5i+cTKHKV0B2RBzTsBaGv60Dkyp15eOWfoQYz09T
         PJbGcL6LL/iNw+fZBQrjmj91ymhMywlE19zDQMbXzCZf6EeqaNUvI8+oft6Lrj4IE2ea
         2U/wi2Wn0OSvNAkB8rPLrKxlDDNoqrTBCOYn+msJdgcRkkswaiidNFFRZXI4IXOBPFUN
         1dL4/Z2Oci7ZFWnMY+NFowMdF5SUsljFig+fx74oSxUvBFceplOSEhzz94TdeOVcAGEX
         7FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263364; x=1779868164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poSwSX8KIzSZ2M4DpkwCMfU4O5+/PFhY4YD5GkdZ4U4=;
        b=QgM5o0u2OeAzUJ8cYSQ5gHRQXqqj133aMbLAHKL/0ByeEx00No8tz6ot+dZnOOrJji
         8ReVJSzSTkp2CCH0EY79QVjM5l8exkV74RDYyl4trCIcbpts+QfUsYban6l+Xqpalxa9
         JmCeRLwNPv3Emcb2euD4ySm2pP4xrs7keQqmBY6ruwXRQGLkvrtIW0sZkvpB66+AUkqB
         frsGYMt+AQMPfDb1T7wYi39fRBTPNhbq3TyJSIAkLMg8i/XHNfr5rYeBwHByLvlja0DE
         HadtUHG7ZGVTHbAvzAzCuiBrwtNedPNoTp5JxeUzZzETBuZRELbmGbj31D67KF6SAqkm
         py7w==
X-Forwarded-Encrypted: i=1; AFNElJ+a10m8fZj0cDocCnfOrxItOGHQNDBizl0FBUWGdV7tyQEe3JVeZYt1KZatcU7osDb/OiFiQw/dkusDEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyip3XUbBkzpk+JaYPWUHWNzyJQJlUZGM/5w2I1suHEgU784Xs7
	RwcqbdlmqwTYpnyi/h5iszG1vB8mR+fu7kvvdQruK1CLnkdkT+TPMfUq
X-Gm-Gg: Acq92OFSNMq7/sKKO/1wb8SJ/ic1lMEYpmecu0qUXMnjLZ+iAPmW8SXBW0GQV0WU8ZJ
	WzIg192cdD1N03ok05bwRHdatr1TzC3dM96F2dluWFuL3WQRdCtLKeILnSDLvCun/Doj7KmmYu7
	q1wpACeyGrfV1wZvP/WwjvYRUcPqZtwdiHtZ0G+Ok4SBJQaaGY2kIFPIQD2P4ZxcTuIbaJQRLdU
	zSGeK3pD3LYQs2K+RqZ3YE8N1E+xlqE9Bdd8l9rDEHGbwtuLMeTnOEnPzPL5i7JEsjVzaP1laee
	9qyWO7qN+8Ag84CzuCUWY3hMvb2gqHnUlevgzPB8aD6NUMU2YKJeUzv5r5PKI+D1voiILsSH1wp
	JpWg7AAlyx+UdKgcJ/9kmtGO53kIurtlPaTVeJC/u417v0TmeZnWS1Avj7X/BM58D+uBKmk8FSD
	wghY02BISFCGMqsPh9+TS30fkGkMWedZ7P5To+/Xb2KvGAy2tYOWNa9/blpvXRfkc/jm+CkVJsG
	WYJBdUJz0gu7aW7oe3Vo89rfCgho9w=
X-Received: by 2002:a05:6830:448d:b0:7d7:fb03:f6ba with SMTP id 46e09a7af769-7e4f2bc83e7mr17485452a34.21.1779263363819;
        Wed, 20 May 2026 00:49:23 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd10a3sm11467869a34.16.2026.05.20.00.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:49:23 -0700 (PDT)
Date: Wed, 20 May 2026 15:49:16 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
Message-ID: <ag1nfIFcykmQHbkk@fedora>
References: <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
 <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
 <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
 <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
 <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>

On Wed, May 20, 2026 at 03:36:12PM +0900, Tetsuo Handa wrote:
> On 2026/05/20 12:06, Ming Lei wrote:
> > The IO after close(loop) should be from writeback. rcu/sruc isn't necessary,
> 
> Gemini's comment is that drain_workqueue() is not sufficient for waiting for
> do_req_filebacked(REQ_OP_WRITE) requests with cmd->use_aio == true case to complete.

Anything cleared in __loop_clr_fd() is not used by lo_rw_aio_complete() & lo_complete_rq().

So why isn't drain_workqueue() enough for cmd->use_aio?


Thanks,
Ming
