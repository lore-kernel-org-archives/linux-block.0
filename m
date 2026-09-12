Received: from mail-qv2-f6.google.com (mail-qv2-f6.google.com [74.125.230.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8543630AE
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789185579; cv=pass; b=B4LMe+tDM22EonFcEtwxrT26hD7tLHTJ2ME9+SKOg6bXDlHaQtITv5lvvijqZyPLCAVmJdpmylc2bE1SwMMucFtr5bf5UPY5nF/zZVaBt8Dek+w5+bAPp/Ulmj0YuEr6cse7JMl9eYtpHUl84A6rYtwWK8nU+2suO2crzTm+tY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789185579; c=relaxed/simple;
	bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKQt89wZoKxL0BYySeybbAVh/CnFa7BytkA/xriUGcMEdv98QzFN+JXvhCp8o3TZ138qxEJh+6O3Eei1KSZXGXFgGSEHV3Yzu++1mwX37ZXppg9A9fet6qhnee7jnkMx8D0R/7OmUv/wlo3ZAsZRTXqpVXGLb6vg8wdt+CByaZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUi99WX2; arc=pass smtp.client-ip=74.125.230.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUi99WX2"
Received: by mail-qv2-f6.google.com with SMTP id 6a1803df08f44-90cd0a3019eso6291996d6.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 20:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789185577; cv=none;
        d=google.com; s=arc-20260327;
        b=GBjM5vjB1PG/KUsrECMvXBpPpRgsCum/28DsD1UlFVxP7p3HLKfHQRPC0Rt7lHPgtn
         LIIepgFToaQEoBbT3MKNFN8gqyDUejT4UbK+GEq5nErQzNFYWxuoLhc7x1G4X/I/mvMi
         RMoBtL8oq0ZzJZE25vKMdEIu3W9kO0c079aee7HIDsgrplAkS8St1ItcNo6eIqySb6Fc
         b3KfgK5ksHpL3iVUKuvPiyLbGNUoRONCwPBIVN9hLb8J2oco33yQ00Cb7/nGuLpkzzR3
         r+fE858E5HDK/1C3oB140d3nGFCKwQdAEKT4O0eTvfkyok+cZRB+eZUCJFLU1krlt/8T
         tjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        fh=S4i42nX5EjNoZJyJO3u+t1hGBu14K/2iYXKDU1hHTls=;
        b=kE5CbojwUUvSLYRdc2rjGC/GuMB+Z4NoUrSAD6T+QRfZQijzIb2W+iOSaHbLHdO21k
         AUuYRynhHz/86HRubSSPAu6MKWcQJUOtl+5LzzKAkLKd8VtxtaJbgkSGAosqY3vnhycZ
         Z95xVZtMEHiVCdMCFoqNo0Nvz+SXkB/R4x72+ft8kyw+bdmmuNzKm2L3Q49owTTJkNr/
         7TRqeIvJMDp77f3wihJMSsTeiJ/LitJz/flm5XVFgUav123QBg3CfFVnxaozC2eJyzlJ
         qIhKTXWZMDXfoJ88GgFlYTQ3xNbYVbKcvt3wvS7Rh/MWH+QWsN5GJ3gcqcVylHBvSwwj
         Vn0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789185577; x=1789790377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=AUi99WX2mjCEnh94Mgz8UyqQU/oNEA9cIEKZBdzKT+z8ihWUMzk831dQkI3koNvu9G
         FOXv9hL+LCMEPxf/E6B6X3tqNMNit0enH6a996hZjF9P1W9Ca9u/JogjBROhVSBVKuKe
         i1ZglNYBRcPU+heleoHDLB4sNQG/UeUlV3ciG1mn4mte93xJ1PyBBaGWQo9SW/MmOyUE
         E2GuwCGaztMXULuWO9e3gDAe+xNSNVCpMSpRBjuIJOXYQi9Lt395uXUGN7PpUrH06Wk6
         hST40P8ADAOoVPLsm4F0dumn5utDUM8S2/msBC6ownOQBTLYS6vL4zC5VkaFucosXqdX
         tFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789185577; x=1789790377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=UYo8EGrB7a6i4NbAyVrHyVACub/89uK3gubApUuiXb4gFb0MQLKVS7/GvQN+xkY8Xa
         X1pmbLRKmkII81BSZbE6jfqTqAwZdyx7GrDn1taVyiMnMOZw2eSRkfodewLpREQtJhrT
         MjhwbhZp81cpDqGSv0OtjkAxxDRhvbXS6QVjLfT/1jwTWNkSRTgjIOh7o9DkuMFpRohw
         aP7bi6aI5401C4//JPBoQgykmsVGaYh7vzn++GigMns/OgWZ/05yKcD5TAOJ+Ztty7va
         Bk8pUOUFpII6mCptCaxwX6NJrWyBKaCYAbm/yMNXSRt95O2BGoSsUl14hwJf7+8h3N2V
         6QTQ==
X-Forwarded-Encrypted: i=1; AKwUvByyPi2zXru/jr+uLhX5tDeRGiqUEDXY6jydLtpGEk36tAQfsERObjpNdGj4Tc8Vd0e8T9bFUi99v0bElw==@vger.kernel.org
X-Gm-Message-State: AFuF++mrPS8JAPzQHK/HTHp0CZ50Ql2jFkcKuNKVdrMJ1vJiPhRTfto4
	qdo1xt3/+/gk9UilciyKKhUBZf/2XZsHLq5jNAU1mGzANaSJU/BuPR5MP39DeqRJc/0uayXk0po
	eDDfVkr44ow2gHJxqppfcS5jYkfZKiP0=
X-Gm-Gg: AYBFou2/Jc8x1KgDJZJJ42eMnAeL6NeH8iFgdCRyzGcf7j8RpavP48zBm+fo25Eeg/T
	bpq/56onor4DWjsCSB/wyyUFnwmBmB7WNisSUsRHZhrsZx2I240uhwM2+xS71/X7xKuuV8FPq/o
	0S+pDNiyI9HILfRTOtmDnPpUpVzMWMSk9wsHLsgbOsobXMi4lopseKFZfdmxzqIsyfhfNbvEx/e
	AaF8DacmWBny2bStrHDtOxiS4n/oqFGzvkEwgmaUKV/6qjLImJu7Fm7YAAeoAMwdXEwzUZogUhP
	gqTekwuo7wn5pSr/DVzs9Xaz5Th0mxYnzKFZWlTEBFQY+Q57ocxErCaobKuCin7LzkJnRZZ4Dza
	NK0yc3ul4q7uJY92dSk+fzg7WmCqhRiSy7nYNiVhW
X-Received: by 2002:a05:6214:8446:b0:912:15a8:bd9f with SMTP id
 6a1803df08f44-91215a8ec1dmr55956796d6.7.1789185576987; Fri, 11 Sep 2026
 20:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <aqRI3N5FPX1dpIlk@gmail.com> <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
In-Reply-To: <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 11 Sep 2026 20:59:26 -0700
X-Gm-Features: AcwNN1VfZ_rXL-z6In5wMRJEgOMU7kPx8LknulegWooIebA5av8sYgSMw6by5S0
Message-ID: <CADkSEUhpe5sX=C5NfUrFMoP9fOGNiFaJ5QmEAVJ=80p8H8S9HQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Karl,

On Fri, Sep 11, 2026 at 7:08=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The Risc PC and NetWinder lost their audio drivers when OSS was
> removed in commit 727dede0ba8afbd8d19116d39f2ae8d19d00033d. RMK was
> working on an ALSA driver for the NetWinder but never finished it
> (IIRC it is in 2.6.0-rmk2 but probably doesn't work).

I just remembered someone wrote an ALSA driver that works on the ISA
card version of the WaveArtist, which would probably be easy to get to
work on the NetWinder:
https://lore.kernel.org/all/1440445816-28593-1-git-send-email-linux@rainbow=
-software.org/

Ethan
