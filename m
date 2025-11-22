Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD0F9D9
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763855365; cv=none; b=VMZNyYLSP3E7qqWEAnXOxjMOwazi4LyWXz4d2f2r5n3ccsY/GTDHeoj+ySifWRji0imRW3xtMmQEtdcp92wSAmcf7kKiM4jboz/f1MYZGz5AX3zbaPDCFX2ijUwkYknz0+aIYWlxHVfabOJ4pLm27sD1mYTtd9L5wHE+PkipfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763855365; c=relaxed/simple;
	bh=SxkaGFZiEyjaDXsfQ3YzJYKoAByRV7CVdKBdh2zTqPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDNlJHRd7WhmgxLPlk4B6vJ3pCPc87d+E7MCir8Rpj35JbaEADxkE74d7Bds2kD+JUKTw4Rm78n5IskplS96D3X2pPmpz1xcDZIJvdUu527CT5V1sd4q6OBbAWsV8h4Md+fscX+HmtfHAxwHIE3krgf9IL3ozLanpMvaSbUNxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MjotCAy2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MjotCAy2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29806bd47b5so19407785ad.3
        for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 15:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763855363; x=1764460163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UW+eRDPoYF+KU6Xqx6zCWEO1tEVVIaZy0NmGDfMcUDM=;
        b=MjotCAy299chgGAXq30l1doPKW279Ovgswd1+zyDwyoDI0stT7uk9Rj55CYcnaigSF
         sqQVcOowX9DaMDenY/8R7cugzv019qr2dxUib5kxkUA4r39N6dFcpeKigVk8mSY/RS7g
         t583Wf2ROfjgo4H/rHgzFiR4MKEgs6RhXgxqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763855363; x=1764460163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW+eRDPoYF+KU6Xqx6zCWEO1tEVVIaZy0NmGDfMcUDM=;
        b=hIWOpVmd1S8hptTckON//6/wkeA1J/1S87/1X1MPL302ES0Q67HQdYoaknWn5HFqjW
         hHldFrum2BKHvYSWSWW9BfBcIW8ht/p4Fe+0zr/L3riMRQOghL5GuI7KaSDmdCc1dbYL
         yTmEEnmnliFl+9f2rz425EMPZpegZKviFRBdzdAGbud4w+/fdIMkENS7ARovC4Hw32pO
         s50q9kPEcjZwAF9ZtxmbJmWYvBi4AQzOWOtimq3xsc0D+iBfYrVNqlXkRehHCVIxVpNe
         3m6PME7cYgKjBlDbJLbCIa0GiJLh7gHKXvt4mi+tjJtPAbmkb8w54NgsqW2suhlCfM61
         7T/A==
X-Forwarded-Encrypted: i=1; AJvYcCXGeJCQdCcDHFky0D+HXIaRtEOzNZOLdBDfVt7a2lrqbn0BRVxHR15Q1d1H539FX6g3JcadqwpICX9oGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyncMcob5e9zrlWE4u74AR86NmhTmOlvJScoaA/YbVdLaNngaSG
	gVy5rewPsIPycf6Wo+dnIUI04dnbma+l8vUGXWYddHyGIfuC8jO0gNXdssspdkwHSvbcQPBKFfw
	Y5Lk=
X-Gm-Gg: ASbGnctJuZ41q1jTN+8bUjSj35dY+wF/TU2Aca6wdxTcg+EXIF8un2NEwr73xlmPex1
	4kPkGajKIINW0KUgnER+DgPYjEeuh0X3QhqVhczuqcipw49CVUFrNLiUbB6edbmWZPZ/VLo/LOg
	P1pj7zVaMJeUqf0zpUNgMZp9qRA3jaCRP3SuI9PsysWkPmT/U3qrG9De+/MouxoicO8exsY8A9R
	sXXlh0Lvy4IXzQEsM6j9jsdSJufQTH869Fk0jIbuORNPXs4qsTlJCBWbSre/9jgGCDEQ0o0acGr
	/mgUNqn9GdhvFDgaabyNFYcsJNPPYoZh923hA3KjLypnFSOAwsDmdiJO7Gf/YaIEj62yIKDDBYB
	BExCV53LsCqCoQz10v4DmnHuBoyHEHvz2RKmzK0harnDJlIFBnRMYmvcte4x4IkaI6MsmBcAkR/
	RRJA66ULxejlJJJRomDNNnnaQ/tXix3amDCj77YXktgAPldj5meg==
X-Google-Smtp-Source: AGHT+IH4jcS+xtBExdkrUh/PqxDOHrrG0hrcKbrp/NkX8lIW/tOBtidSFRn6HKRqk6RmeBK/ozSTYg==
X-Received: by 2002:a17:903:40ca:b0:299:dd98:fac2 with SMTP id d9443c01a7336-29b6c6b2646mr95443735ad.54.1763855362961;
        Sat, 22 Nov 2025 15:49:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:296e:57d:751e:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25c20dsm94265595ad.59.2025.11.22.15.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 15:49:22 -0800 (PST)
Date: Sun, 23 Nov 2025 08:49:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCHv6 0/6] zram: introduce writeback bio batching
Message-ID: <wdju2lsmlwvz7oqaku5xe6gl22t3pdbgcpgkdcxxeqavwxgc7o@4bmil6a3zsgp>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
 <20251122135406.dd38efa8bad778bce0daa046@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122135406.dd38efa8bad778bce0daa046@linux-foundation.org>

On (25/11/22 13:54), Andrew Morton wrote:
> On Sat, 22 Nov 2025 16:40:23 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > As writeback is becoming more and more common the longstanding
> > limitations of zram writeback throughput are becoming more
> > visible.  Introduce writeback bio batching so that multiple
> > writeback bio-s can be processed simultaneously.
> 
> Thanks, I updated mm.git's mm-unstable branch to this version.
> 
> > v5 -> v6:
> > - added some comments to make code clearer
> > - use write lock for batch size limit store (Andrew)
> > - err on 0 batch size (Brian)
> > - pickup reviewed-by tags (Brian)
> 
> Here's how this v6 series altered mm-unstable:

Looks right.  Thanks!
