Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F81CAA8D;
	Mon, 13 Jan 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782424; cv=none; b=sevLrmoRausl7RwoSuuR3tEJHmbavvtmSTzCs+UxZXuhi53oRLeEno49hX8ISdtH2KOXxuGslZjhbPboPkrcsUDE/om1kYx5TTlbPgPIRmv4qx4AvkSR5lB+np+hxXLLpI3bZy8GpoaUEAhWRK0kRLorFKaY2eJXqiNpjn5D1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782424; c=relaxed/simple;
	bh=JF2yfePw/PpoDohheZN6YJbRQSC2yRQ99635lugFaCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTRt0oILEgaZNCBP+DSHZey1CPzggPqK+5VHFSDmVIs2s2ilq24Y+G6m04x0QNhsQy1xWKxcLwbhvzWQbDfmriGtfsXx7CQLt62OOVQwEtfwlT1r7cgdqpPBPT+9wlPQrrCxO/O3btOhQVIZrbNLxRl0J3ePo/k1CmCJt595uuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJq85G7z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJq85G7z"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so5864013a12.1;
        Mon, 13 Jan 2025 07:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736782421; x=1737387221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCSJ5i0+b8znVFiW/oIl9iqyNh3XwK6OBgp1Gw05uwk=;
        b=nJq85G7zBtgw3tfg9xIt6V7TGigovOdDILv1um7v7o3WRyZ8PkEsQUI9c7SKVMZeBM
         4iplvCN1MQSGcCec9ZxVA0WoGuTv6XHgmFiikruqNen0TWhtG1qoGyzd3CMabaY+OhfK
         sFpTNG+sii2B6PlQD4jDjEdab9IesYlzol9026TP+TlGAtZaDP1gOILRaiMe7yqS8i/L
         fYgLaLFFuI44zRffYtGC0Isa0mxRb2eYHELbb/xPj1e4JmXv4rvpy9gRAlzwXepdgdur
         RAttzDqNkfST/wyGJFg8G2oqZeTCzBYJQ/M8E/bsNrbCe7kw00pgoE4ZUD9u5sZLT73p
         W4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782421; x=1737387221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCSJ5i0+b8znVFiW/oIl9iqyNh3XwK6OBgp1Gw05uwk=;
        b=Rrd+l27d1JREVCqkZ263GOdBib9R9SXIEviLZ4xQHZ9s097Oca+QunkwLebobBgBfV
         22ZNuBX4gJ5xVa6gHFTDNBXbloXbF0pKAw9CzrRihTvtErJPaW4eoDueW7v/MUyxCb1w
         3t+a6kenidCKku4C8L5C3MvuH27vD/nBQLexnVA5hdqcaH2RrOGkB2l+Z97sbnD0vcbT
         Z1e9ZV5QXcG8ysO+LJnf1vRHBY9gECdyBO/3tRm9a4HjIJrlZO/UJ0tnGRWcXKfoywsz
         Ij63VwHFgfsnTBCiR47UANAGR5zS0j47oS8RhXW66QK/ZCn8TRFsHWSc0FohmbA664oY
         C7xw==
X-Forwarded-Encrypted: i=1; AJvYcCUPaftTkAt/rTCvSTpHpzYDW939vUO5fxoe4TkztLe3J7JkOPvmwlmM9EffpwgRc+WAvlsQD5GPztNm+A==@vger.kernel.org, AJvYcCVkNV8TGA1AAAfJ3FiOTuluLFhEbPSmYEOvgB6kJd7Z0Qtz/HPhYJfAJXUM61DH9/W/glRBf8kTYQ0O90sI@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOtj7EtBVrjc81kuvw9WHCAxulgBJvuAm0zzaFtgtod4CJCoJ
	oxUT4YBr3hLiima/CHN7AqmY1g7D5PHhg+kp0roy/TyHeO75TqN2
X-Gm-Gg: ASbGncshMyaJnU7p97fUYFnXjXO7vpd0s+dlrNDR0vEFxL9GmtVFqSVQJQXCJ0hJyee
	kbwKnjSYwl1Z7siidOkXXZ+VIWCIhVCozc7EChxKgcZQdTFo4di2sjQzW5mfygX3txczDoxy9O7
	PcSqX3m0+CR9fKL3pd/awcukxstsE2ULQJvTHBJZRwnZcclzKSwvaHuxRCu4TiDZ+xsZGnEbh2c
	RnQmz4j1+QxqoH6CmaszjyOR78pRfO9ygZ/uTjpl29oFAkEz3wricivbajr9afwPg==
X-Google-Smtp-Source: AGHT+IHdJsfGnR1yWqiUvKH9Ne9gmQUzZompva3z/nN1uKKqDtRPcY4jVdss66SEIg8akvOVzpQZzQ==
X-Received: by 2002:a05:6402:40d5:b0:5d9:f21e:ff5 with SMTP id 4fb4d7f45d1cf-5d9f21e18a0mr437309a12.16.1736782421111;
        Mon, 13 Jan 2025 07:33:41 -0800 (PST)
Received: from debian.local ([83.105.230.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c3fccsm4944829a12.21.2025.01.13.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:33:40 -0800 (PST)
Date: Mon, 13 Jan 2025 15:33:38 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <Z4UyUntV70G_RYyF@debian.local>
References: <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation>
 <ZyITwN0ihIFiz9M2@fedora>
 <Z0/K0bDHBUWlt0Hl@ly-workstation>
 <Z4Ulmv7e0-Q4wMGq@debian.local>
 <Z4UtPNtdgVrA9ztl@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UtPNtdgVrA9ztl@fedora>

On Mon, Jan 13, 2025 at 11:11:56PM +0800, Ming Lei wrote:
> 
> This one has been solved in for-6.14/block:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.14/block

Thank you, yes I thought that might be the case.

Would it not make sense for the fix to be included in 6.13? Or is it too
big a change / just too late?
