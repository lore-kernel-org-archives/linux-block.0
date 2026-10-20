Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509542;
	b=XYwx3YN3s1Q/DF661n9um9v90exmjtpk2ZgVGRpV/JA+uAe0Pq38Z1nz4zrx+7gIJqjH
	 LQgtvegIy1SCWX9u/NyqsIZDOG7kBqcRBhxX3htHYajPDXEEncDBP5Ja31LQZ1ArJOUKu
	 ktD3t2r4z+mUGdsFnqdv73vWd8xatbpr2oa1eeqXHJv6dIa1bRH7pEwFx9dXXvucXJ3Jz
	 sMqPR92FT6Ang0ewYJ4OEPuiF64XQp2XS+336084mkgylGcA9IZAaZ6LYa/6boJqolc6J
	 UiFnj+YXJ6HJIl+PIq70mKsUPDcaeu4pQQyFaPyfhXO0UhHXJwI11BEnPhcbZoyPyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PtTdxBCaK4IP3IjSC3LwSEdRzZKszREp9Gn/OsemyOU=;
	b=QpAG98VIlvDWREck1KrrtS4TYTwQyCOm7UEBfwm/53r1CgunLxG+HQpGURp9HcJJX4rD
	 NNN0RcT+lLkzQcpcKPShTgbmlNRRvxfJdHY8KRwiY7XfZQwSZUX1MNc6akSai8IhTE2C5
	 P50ac2w1mrcEUEbm5e1Kj+TK1MpYszfxD/ozBnd61bKnlM39Nn+wHxi85znx7mu/nEqbb
	 jRQHmrpj2xcLIRo2PBj/4byemh8liiQnKV2YCz2cJh5ca9TcV1yYaPQOOY33ofPUrsGVr
	 chDV3n+1HO5dn+0tnz423y/pICnrHhC7wVSCXx4tFKug6fySU4jv9CMMUvMqvqnPHxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XFuJhp80;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03188606A319
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 15:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03188606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XFuJhp80
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1efc90e7cso5190465e9.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509540; x=1793114340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtTdxBCaK4IP3IjSC3LwSEdRzZKszREp9Gn/OsemyOU=;
        b=XFuJhp80/8pIp4xz+9eTzbRP9QXqCF+5MMZ4eYKZiCgckrjJmCfzfyfNo1c1dSwUYS
         rTJDvupCCiQyxyBFRnzl2OF9SI89n1KWas15qNuNL1wavkU4fgTDvy5jVeeR4pxi9JRw
         KS+exgAfWd9LWqDIsLPwZq1kZQ3RoHgUVW//9xyI7Q9dDh3Pi3YvwDEVrtdtCHDIW9/o
         S9f7HDZObuwt6tOP/T2R7MlBWnIVvoWo6QN5UUWFFB8mdCtKbe2TyDrf4hPObNgeTU2X
         tYNyGvy80h1SLa7LkQLkc5ZYkP63XA6B/C1xK2LUgvK+CTVKKD2LzKbyFtVssza/aEif
         TwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509540; x=1793114340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PtTdxBCaK4IP3IjSC3LwSEdRzZKszREp9Gn/OsemyOU=;
        b=fdLu5uWPHrOjRcu689ynUT2gOD9vHmN2JzVPymxH2xjFtP4rCPDbJc4kwLYg+5uaOK
         X3v18OimpXxIpniQOCJVVAUCknOJTUIRpsBrMAaniPuOfSpTn8lFi5a+HuNgwImh0wiH
         8rjybprenKr8BmDM3KqWRLvT9MnMPFtDCMY6vh6AQQS5cA24BCe1CHU2b8GVAU9jrjRe
         w0LA7MaXUHWtSPwMEocoJPLitvPuK/JvQRs/IuXmrT+8+2aXJoALPbaM3hh8S/esUTyx
         ms3APsVeFdiAJqFpHKrRk9Z2oNYt/Y23b610/yo1U08W5Xwzrs9hhgCd4mtlahNCQdIr
         d17A==
X-Forwarded-Encrypted: i=1; AKwUvBwUIppZkUzHT/2f+wV+EccTsWH9nAYDQefj5mDMdRNF6lQYzLZ6Ps2A/RJMyT80DrHVjaoEQvpGBYN/Ig==@vger.kernel.org
X-Gm-Message-State: AFq9FYIFgDFT38aoGNNvMIxubhp5kr7xmurngcvHld4IghKp7e87MKod
	7SjqI/0EWb7Z5IsQycR7Fy5trr6nHZ5SNIhVnqNEmFSQBkkX4rKar/bU
X-Gm-Gg: AYBFou2LQiAi3ZwheNiw3M9+QCbsvxdEz/UMkvejh2hT1UoQ2MCRPrUJb0KXsufchAO
	ApyGHcEqVMEtUvxU/lMxOuFURmZAV+slSQUBfDTZiUzB/A0JicyR25/NxrijDr/sYgSVoN2ZMvr
	7WWKWJGpQolL6NGMTGNMPxp6QonuhMFN7QGENxHf2T3/ZORr6Dqm+cr6WU0ErfufO6bMxAIOlaP
	n65uWV38V2VusENRqXGPiQQC8QyYV0BZBFtMAxdsoL0XwykynhbKNxY64gJYCWLvgdC/HN+ZJUs
	GEv+Xk5t0dZOI6vSWaWd9IOAjrOB4hYPPIeYK2A0FYh+LG2W5QkfqXFHA2akHJZ5gB8MqM5T2rQ
	JsXwECR3LiZ2qopCDSXCSu4DYPzUc6LlauEfgSB1qP5FN9O/MVILFQ/52QI+EpeayysCVHcupVt
	jezkThYFhFhk8wbayaId8ljYdHdmv2XgXuTIxBH8nYvFNsEXe2NEx3T46bshT0ePCMjjFuDZLHu
	ckbUJku7Uf3YFPbkSbaQ/o/lpMq/AV3K27vVtLsc7k=
X-Received: by 2002:a05:600c:8b06:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a1f4f7fb72mr60920705e9.12.1792509540249;
        Tue, 20 Oct 2026 08:19:00 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d699dasm84574065e9.12.2026.10.20.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:18:59 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/4] nvme: add nvmet zone report and FC regression tests
Date: Tue, 20 Oct 2026 17:18:52 +0200
Message-ID: <20261020151854.90498-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atdEpM1uAdi7Dnh1@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com> <atdEpM1uAdi7Dnh1@shinmob>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 07:41:42PM +0900, Shin'ichiro Kawasaki wrote:
> Andrea, thank you for this series. I ran the new test cases and they work as
> expected. They all failed with the kernel v7.3, and they all passed with the
> kernel fix patch series.
>
> Overall, the patches in this series look good to me. I made some comments for
> further improvement. Please check and see if they make sense for you.

Thanks for testing and reviewing them.  All of your comments make sense
to me, and I'll address them in v2: configure nullb1 without calling
_init_null_blk(), and use _have_null_blk, so that the tests also run
with a built-in null_blk; rename _identify() to issue_identify(); and
drop the namespace read from the Identify test.

nvme/071 has been taken in the meantime, so v2 will also renumber the
tests to nvme/072-074.

Thanks,
Andrea
