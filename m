Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4225B090;
	Tue, 12 May 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611540; cv=none; b=NTbyop7BqeLnVBUtZbWKHu74u0jI8eb892OYkuN/7ZQ1KS+Pivaw3kez/c8ahATJBnI6PIT1e+H5ayn6C5F+M3i0tLzC+TJpftCN6UXV++V1IF+Je9OM4p2fVW0HkIEw0pS2h+4l3L/ZzLHv7Wj1MiuZcJib8riIEqd6215YjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611540; c=relaxed/simple;
	bh=4e/PO5F4/24IG5zMGckMy5cuQjw1W0ONNPFim/hx6nE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDmzE4CRuEFgs5s4MyJgB/Su/+1+RAKut9HRUb+1Lc/eskdIHCSpF8NKH0QWFNP6433OC0pvDk/1h5oH6nwaR7yVT5KzT8qXOnbS3mIeC36QBTrmQYnnRpgzM/L923A5VBxRNebPxns3JezBoxLz0r1kYtjVHmr96PH2qwQKMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=NVgCD8sn; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="NVgCD8sn"
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:143b:0:640:90e9:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 09DDE81780;
	Tue, 12 May 2026 21:45:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp) with ESMTPSA id OjPSJF7RC4Y0-PyoFuFxV;
	Tue, 12 May 2026 21:45:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778611526; bh=YeHIwuxxvgWrkXaglYV81IABjBK46YWnyMIEMXTBqes=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=NVgCD8snIeib+QuSw4uO1915ScQ9kS/YWiyrF7jEylTn9eZ8YNzi4BHDdi7Qy5Qqs
	 4BeIHds5ZbCrmLyMlxiYWwA3ja8qEBr3GMcEahWNFXUWHhqiboruYG68o1YB4yYxP3
	 rRoBiCu9mEkDyk9kukCI7xj9Vh8QUp2+ewLffJps=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <26c1f22358ca894945dbfb8b7b6376a8a59229c7.camel@yandex.ru>
Subject: Re: [PATCH v2] lib: free pagelist on error in
 iov_iter_extract_pages()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
  Christoph Hellwig	 <hch@lst.de>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Chao Shi <cshi008@fiu.edu>, Weidong Zhu
 <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>,  Sungwoo Kim
 <iam@sung-woo.kim>
Date: Tue, 12 May 2026 21:45:24 +0300
In-Reply-To: <CADUfDZqnV5BRwZq3c3Atu8w3gOm87AbmtexL=MenWcSbTVOgvw@mail.gmail.com>
References: <20260512170525.357573-1-dmantipov@yandex.ru>
	 <CADUfDZqnV5BRwZq3c3Atu8w3gOm87AbmtexL=MenWcSbTVOgvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 10:46 -0700, Caleb Sander Mateos wrote:

> The mismatch between ret <=3D 0 here and ret < 0 in
> bio_integrity_map_user() would result in a use-after-free in the ret
> =3D=3D 0 case, no? I guess this should be fixed by the "block:
> bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()" patch
> that landed today.

Not sure about null-ptr-deref but IIUC this patch fixes memory leak
at [2] but not at [1]:

        ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
                                        extraction_flags, &offset);
        if (unlikely(ret < 0))
                goto free_bvec;                                 [1]

        /*
         * Handle partial pinning. This can happen when pin_user_pages_fast=
()
         * returns fewer pages than requested.
         */
        if (user_backed_iter(iter) && unlikely(ret !=3D bytes)) {
                if (ret > 0) {
                        int npinned =3D DIV_ROUND_UP(offset + ret, PAGE_SIZ=
E);
                        int i;

                        for (i =3D 0; i < npinned; i++)
                                unpin_user_page(pages[i]);
                }
                if (pages !=3D stack_pages)
                        kvfree(pages);                          [2]
                ret =3D -EFAULT;
                goto free_bvec;
        }

Dmitry
