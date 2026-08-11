Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDD299931
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421059; cv=none; b=FEbuz1YaB91YbnfqMrNBKssbSyzWk+Zro22j4hUE6+3AZi5jaGERZwl0looK6zS2t+9hDHbQ8BR2DxzrYh6TA5PmFMeMP3BNQJWw55wqrzZp4HfyQRBpM6o+09xAjWyYGoELtak01wrbDPPZNQrYRSBNyRr+QOwuD5IF+5EXGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421059; c=relaxed/simple;
	bh=lyeK9aBbtnh8MHhK0QlEi5A9QY6Umptk7fn2lOsOJDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEdCGldK+k5gLHySd+3cIJoMOQwBv6QS5SohC04xU4ppq5Zb2Y230rkZZ3PiBYQEjovtu5CEwq/IaG9QBx6qB3X6enAebban2iGRnIx5S6x4PNab147N7PzVq1Mj9w80HwnPQcg8widjLJheqwZSc0jHysUTlUetl1xNRIQUPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCb5Xtfk; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCb5Xtfk"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ed2a00f12so36130107b3.2
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786421057; x=1787025857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y3vyjW0DTZeOqW+IpPjwitbNL4KqPKpkFiayP6aBYFc=;
        b=bCb5Xtfk17WNgU6jTO4ceeZG7c8LcW6MRktSc8kGuXHbJ8+UhamgfQqSiMRr41yhr8
         bsn6gGInXe+FKbtRqUpIaBCC7vm3opu0pK0IPPQIvlYhaCjFJckgMPV/4mLfV7gVgaHj
         OqUDPX+Kpa5vjPVn3GmsFqZSxpyniwy2FUZYFFrdaOYK1xXmQDcQnzOpvpBgD15Ja0fj
         XlirUspDH3RLDOquhi1xATRIV8ICbZOKkyXwB/qLZmfA/xrTZEVm2sNHgrpJE+pHWH1d
         7205fGmJvIIHXpmyPpktZYMW3RbB4GVhCTjD8HPJUmwidhU1SrQgNbeTcDtKy+F+0NZl
         x0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786421057; x=1787025857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y3vyjW0DTZeOqW+IpPjwitbNL4KqPKpkFiayP6aBYFc=;
        b=Q0oUraOWgUOYnIqEoFIJPQFlbuHt8zLGxYQ+5rOvnjAI+lgMBsbQ267rJYeq7toe0I
         Tm3iy7pmqcymMX0duAQ9hNvHImeBbXZi2Lde4Y4etiORiabF6kdnvo2iHmjhslOshmjc
         p+pQgFIBzDx3WCO0RpU0TRpzzZK2/jQvHxmi1Crc1WL6UwOH4dacSaI3sadz7U9HtXua
         HsL6OKjo0rqtWGEr1cgmx3pNPHVRIzf/lzh2GPxM0yiZjrLmwkr3h/Yvgo5UriXSvD3x
         3YQmesUmhabd4RLhaQY0LphRrNVEj8dFrqg4bQTCKBGi1M2MgVdKTqmHCmczdevhjqET
         oKrA==
X-Forwarded-Encrypted: i=1; AHgh+RqWHjWJyiJ/RGAxI9bGo7KPjXyaeT9BUufhCFU59DVLubbxcwTJAXMfK+KmLAxXbTod0wIPMa91tHccFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydxgU4ehNc6OmEla20qARijURPFTIrW2z4qOIQsvyCXtTIAPuy
	YCaHKjf6tiNtOrbYT8KoOx4Iaetagx1oEqq/dimDskFsz31dQlBcAtU5
X-Gm-Gg: AR+sD13JWVhm1PQWgDW1X1tbYOkt6NudubnV3GCAtPQWQAQFlexbJsJF443Y1t4jpDy
	vuE3ctIN4VxOZxEcURgcekDvdkXDDV0VF8rWT0aICfq1OVgDoo//VC8RBd1gh+Iwa9czOIjdkcY
	CRtL2OboJ6kYygrTW7fxGHd8X6+fvdZ3k+5lO1r3YMdm3eetvQ33FPfurbP5CNNxBGiMTrRqbfR
	goxIsh9ZVEnQa2GfCKBOqkBx01cyLGJZNalj5Cu2iBmNpm9qoB4fn1DPOGAqFaxXfI8R2bLDywf
	Cu2VCcmiQBkyP41uEmGYEbS58NBEAShSOljS8TPCQUjY76q1GzQfQDGUFJIBxSDIfcK8os50Uqa
	8SQ98xzZsTr0UClh6gdBw+89rvaRiP/O16J4JQkzLR9Ci4FtQYJH9CBXPiJY9iQYC+nsKmDLkGi
	wDnhXcVnfUwAsFeGdtp3yYRQ3qEzjIOojpNYZikXmkhiuzUskg112syNxYzI+D612cjklanj98t
	4rEmzkxduQeDDTxIQ==
X-Received: by 2002:a05:690c:4b10:b0:81f:e85b:f9da with SMTP id 00721157ae682-82f2f103751mr571547b3.33.1786421056694;
        Mon, 10 Aug 2026 21:04:16 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ec39021f5sm2842817b3.32.2026.08.10.21.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:04:16 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Samin Y. Chowdhury" <samin_c@outlook.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Ruimin Sun <rsun@fiu.edu>
Subject: Re: [PATCH RFC] blk-integrity: fix slab-out-of-bounds in t10_pi_verify on namespace revalidation
Date: Tue, 11 Aug 2026 00:04:09 -0400
Message-ID: <20260811040415.1968239-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ah03bXpgFLQjOUt8@infradead.org>
References: <20260531-blk-integrity-fix-v1-1-cc7084f42cf1@outlook.com> <ah03bXpgFLQjOUt8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 01, 2026 at 09:40:29AM +0200, Christoph Hellwig wrote:
> I don't think changing fundamental device properies such as the LBA
> or integrity tag size under a live device is a good model.  So instead
> of coming up with bandaids like this, we should probably just fail
> any such revalidation when there are openers instead of trying to deal
> with the fallout.

Agreed, and sorry for the long silence.  Samin and I are in the same
group and I am picking this up from him.  We are dropping the
blk-integrity patch rather than respinning it.

Before writing anything on the nvme side I would like to get the shape
right, because "fail the revalidation" can mean a few things and one of
them looks worse than the splat.

If a namespace really was reformatted out of band and we refuse to adopt
the new geometry, the host keeps issuing I/O with the old LBA format and
metadata size to a device that has already changed underneath it.  That
is silent corruption rather than a KASAN report.  So I assume refusing
the update has to be paired with taking the namespace out of service.
Did you have in mind

  (a) refuse the update and mark the namespace dead, like a surprise
      removal,
  (b) refuse only while the disk has openers and redo the revalidation
      on last close, or
  (c) something else?

Chao
