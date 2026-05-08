Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCC37BE7C;
	Fri,  8 May 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229016; cv=none; b=qlB4A2nzIq6nugt43cTElKc82oy0vg7R44ewVGsuVWp1qPIWz2QJbzD2GYlNHm3gJ6oVUIyFTvg7ekQdjfTzu8NndjgpI4mJDBc363sxPOFGhyCOoshzIVkbgQp+irnygTuMmtpcfLJEa/otCiz9pR+mlgx3ZmgeflTOszlflXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229016; c=relaxed/simple;
	bh=Pj7koE15BSopNI/Y7CoJNrAoiXs+cwYfL04SAD+c63U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvkXa/NAG17ItXMbZ/FDdbau1WdiOjUrgO+wGUXvzs7/1KydufgxNpjkZh/XsdbYzuv5bs89UiUZ8U3tuerpuARykNWL1texv1/tbafqqGtY0mQoRBOuYG3Yv1j/X9ZROB7l3ETdEgF1gCaCEtKVn5732lMw327Ds5X2qnlWdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ULVIXZTW; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ULVIXZTW"
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 7C1CD81903;
	Fri, 08 May 2026 11:30:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp) with ESMTPSA id 5UBgwfJTOOs0-sRushEvi;
	Fri, 08 May 2026 11:30:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778229008; bh=tEAT9HIAm4EzezM9pdAwS0iT+gBH1o2zWvbDl7ShVSQ=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=ULVIXZTWrb1CgiHb3Fog39Ptx9bp7lZ6icuGIWx1Ue6dsRcBQ8bbBSLoR/Zt83N9S
	 /BpVZ8R8K3/wkVXEptQv5AJkiXLtMrVArc64yGrm+nytoQSvz9rHcgjx3jM8Tq7uns
	 j9Fxrw9htmGuLSNpCM27OPC+ACJt/LZ6Rl25Tuwg=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <5bd98789901e6bcd2b41d646209deb6e48ffb711.camel@yandex.ru>
Subject: Re: [PATCH 6.12] block: fix memory leak in in bio_map_user_iov()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
  Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, 	lvc-project@linuxtesting.org, netdev@vger.kernel.org
Date: Fri, 08 May 2026 11:30:05 +0300
In-Reply-To: <20260507212200-2614841ccc112a082cab6938-pchelkin@ispras>
References: <20260505094529.406783-1-dmantipov@yandex.ru>
	 <20260507212200-2614841ccc112a082cab6938-pchelkin@ispras>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 21:52 +0300, Fedor Pchelkin wrote:

> In some form the issue is present in current upstream as well.=C2=A0 For
> example, there is another callsite of iov_iter_extract_pages() in
> block/bio-integrity.c where the same pattern still persists.=C2=A0

Good point, and skb_splice_from_iter() looks suspicious as well:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b518..bf053372acb2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7343,12 +7343,16 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, s=
truct iov_iter *iter,
=20
                len =3D iov_iter_extract_pages(iter, &ppages, maxsize, nr, =
0, &off);
                if (len <=3D 0) {
+                       /* Possible memory leak - ppages should be vfree()'=
d
+                          if reallocated (ppages !=3D pages)? */
                        ret =3D len ?: -EIO;
                        break;
                }
=20
                i =3D 0;
                do {
+                       /* This looks wrong if reallocated - ppages[i++]
+                          should be used instead? */
                        struct page *page =3D pages[i++];
                        size_t part =3D min_t(size_t, PAGE_SIZE - off, len)=
;

This issue likely crosses the boundaries of block subsystem so netdev
people are encouraged to look as well.

Dmitry
