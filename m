Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.46.152.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340256;
	b=4aiSQohHtNckYWVw9ujusHuyVORrgnRxIYoqd5E0IYc5el2lRtZIsAqfc0k3pEgDfNUA
	 XQcw6Ks6Qnr9ZaoMbiAwoXXfn6X7F53xK9qyJekjm6HViHrqE1lEG/TqKAQzXNjvX1fyD
	 GcpqVDCoDDm2KYkVoEb65chMHe2a+EyOvDn36e55GBSRjl65sLs+r5X1dKLeo1NGXyN3C
	 QhC5jitHweAiTUc7gXmKoebn26JXj0BOEYoxbBstGaHRzM3RDT90xbQYB9LEvWASIzu2+
	 Dwf5CGjlNjwWwGwEzJ+Da/J9ZXm5H547eQm2h7y4T0+enWVPfTUTQS1wFMkAX+NpyZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340256;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned;
	bh=oCYzsvtCL8qUUzLq5NjdenP2r//Mh1mlAOdCyqGgN9U=;
	b=QLGVGowpXlcQvuuAvp5yiucQhDavSg5ea6fzhv/WmjorL9Z1YDix5pkeWhtT6GWc86cu
	 iBXbOXhbxEuboPZdB7bIcC1NQ94g5wuD4HwsqPP9WhLhfAVv2lfbpisTfFQ27G/U4a4tI
	 QXuGA5cggVA2nchsLBqDDA7SbxU92uabZFP7ECMgR+n74K6cFplMRsnveQaODGdv9/5DI
	 3Ee7URqloL9a1YiovYJEAXstKD9I653SvVhZCDoaESp5LilgjFDbFieqgKV64Z+Vq0lcq
	 D5/BIL4a32GJWz9USn/Njcs7D7t6yq+cVhR1lfVmbh983yIJz3DO1udz0yhdn5DMdKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jregg.de;
	spf=pass smtp.mailfrom=jregg.de;
	dkim=pass header.d=jregg.de header.i=@jregg.de header.a=rsa-sha256 header.s=default2602 header.b=efPmKhvQ;
	arc=none smtp.remote-ip=78.46.152.61
Received: from www421.your-server.de (www421.your-server.de [78.46.152.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3328606A320
	for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 09:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3328606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jregg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jregg.de header.i=@jregg.de header.a=rsa-sha256 header.s=default2602 header.b=efPmKhvQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jregg.de;
	s=default2602; h=Content-Transfer-Encoding:MIME-Version:Content-Type:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oCYzsvtCL8qUUzLq5NjdenP2r//Mh1mlAOdCyqGgN9U=; b=efPmKhvQ7ezVwNjpHdTG3iRRwR
	T+9SxR8pUGyB6JxUsEhNkpstcA5J90Ec8JaAJEeSRlu5RYwOh/PIp3kc+mVxzlz6SSEr03/zmp4DM
	2xLQV345KJsoKtZQJnxJ1r9BMUl9PhXSF5LU9p34c5a+BmSK7TK5uWB6IO4S/unICtXNdUnn3PKol
	DWvi1AsfEDMxbJUEemRIJu0eVRwc086q5wxtVA2O//WHvFaXkCa2vOY+zs5A0rC/M5Hf4h1oTNKtt
	8pC7hYllPNlShWq06YrSaH8IrMlXtzOJmCAmbABjhj8CzMQgKfA8VmMuQyE09mfQhB4d+ydwVBibc
	wgoORuUA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www421.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mail@jregg.de>)
	id 1xV40k-000EU0-0t;
	Sun, 22 Nov 2026 10:37:27 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mail@jregg.de>)
	id 1xV40l-000M1v-0Q;
	Sun, 22 Nov 2026 10:37:26 +0100
From: Jenson Johnathon Reggentin <mail@jregg.de>
To: Marco Elver <elver@google.com>
Cc: Jenson Johnathon Reggentin <mail@jregg.de>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-wbt: Fix data race and avoid possible false sharing
Date: Sun, 22 Nov 2026 10:36:25 +0100
Message-ID: <20261122093626.205973-1-mail@jregg.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20191105182746.217864-1-elver@google.com>
References: <20191105182746.217864-1-elver@google.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: Clear (ClamAV 1.4.6/28191/Sun Nov 22 07:27:13 2026)

=0D
While looking at Bugzilla reports I noticed that the fix I would have=0D
written for https://bugzilla.kernel.org/show_bug.cgi?id=3D220759, is the=0D
same as the fix Marco Elver proposed,=0D
https://lore.kernel.org/all/20191105182746.217864-1-elver@google.com/=0D
long before the bugzilla report. I could not find public comments or an=0D
accepted patch.=0D
=0D
I tested the patch applied to Axboe's Tree with KCSAN and a mixed=0D
read/write workload on null_blk. The patch fixed the KCSAN reports, in=0D
my test runs.=0D
=0D
Was there a reason this did not get applied?=0D
If there needs to be testing done or something else I would be happy to=0D
do it.=0D
=0D
Best regards,=0D
Jenson=0D
