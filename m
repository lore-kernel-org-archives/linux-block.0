Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15404199EA2;
	Mon, 26 Aug 2024 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708069; cv=none; b=I++pn4GUIHEEhiD4up71YESJKj75OIFu6gLXHKecypKME+55keCtW1Wyd3IGa4/xKluoJ4qGgdBvZKTGU7ioyK1+HFakN+/VLUpno1Q97hcURwTJqNZlmZsJwKlsFX4sqNrxgwmayCHH0PH0cJeaRlbYUDPh/iTResQ89btOxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708069; c=relaxed/simple;
	bh=UzLwthq55feRRfqVqft+krrc68RgU3jX8QAxGa9eDGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2P+zxMubmxMq8ZhxduvVHiiMHw47mmJUwpD9vdUaxx3Hcc4TGFBC5RzmaV/VY2yaUS7vrfl1ua9av0JlPMFrLgtiBGJQH1HMd4fypPQ0lfGNF56DAhGVv4k/BRr68CDTbdmPOUWgVjQifeYJ2rCboCg+e8MprTZ+Lq4L/bC78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=J88AOzg5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="J88AOzg5"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 34B1641AB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724708067; bh=kQdVjhEgW36oG2YSr9XWxNlwc0D1J7E/TbKSSVi1YII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J88AOzg5d2mrcRi/shhsfd+JF5jkLodxaOB2vkA+6fKsn7rnRwK8f1Wi+iA+d7XFA
	 pyFqqG2eOwkoWgxI3wFl1epMPX3sIHzGciu+5TqNHN73o8mim6qGyTCFnXJV3vtvD8
	 +HxC+InqxddPjB8hwUgQTI7kBMensi7SeNX88YKnJ4FkBO0kE+ySnwYP+S9GgUFHm1
	 yOEiyDpaF0zFAbERVPyu2uD4KxeGNcik/0mHKkmks3jW3KR4XQhhEkhI50Y15tZBSi
	 6APgG3NsE96i3J/3yrPGmDcvmwmOYsoIlkHFY4WwAlJs9Wm1rixGvcCOrJdl+OFJpF
	 walHLGWD7ya2g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 34B1641AB9;
	Mon, 26 Aug 2024 21:34:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ming Lei <ming.lei@redhat.com>, linux-doc@vger.kernel.org
Cc: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] Documentation: add ublk driver ioctl numbers
In-Reply-To: <20240823134339.1496916-1-ming.lei@redhat.com>
References: <20240823134339.1496916-1-ming.lei@redhat.com>
Date: Mon, 26 Aug 2024 15:34:26 -0600
Message-ID: <875xrn6k9p.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ming Lei <ming.lei@redhat.com> writes:

> ublk driver takes the following ioctl numbers:
>
> 	'u'   00-2F  linux/ublk_cmd.h
>
> So document it in ioctl-number.rst
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index e91c0376ee59..5baae6de2861 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -292,6 +292,7 @@ Code  Seq#    Include File                                           Comments
>  't'   80-8F  linux/isdn_ppp.h
>  't'   90-91  linux/toshiba.h                                         toshiba and toshiba_acpi SMM
>  'u'   00-1F  linux/smb_fs.h                                          gone
> +'u'   00-2F  linux/ublk_cmd.h                                        conflict!

Applied, thanks.

jon
