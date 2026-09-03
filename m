Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476384B1270
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442155; cv=pass; b=fxi5xEux3L4P+nBqXji7pJzqSdgPErzBUF2s3ZLTA5NJlxOBwaYQ8IlbDAX2mQYyz1cTJ4hyYtw5PFfOOedz3tOvKIg1SJdAY22NRhfpKh2/imrkqZh/I/8PsDdr82m8yH8oxLlWB72hgCd9X3fRMgTIied/up0cqD+6Q2SRw6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442155; c=relaxed/simple;
	bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbvnuBRgZTxQw/9VeY0oIRI798RZoIHipBmiemc378UBlll+wWFpXyXtTAAw4v8KGFGsHa6/zMGQMeTz6c9l44cSLmnp7/Gu4UMtpqZFQppexFLA/uOkAoQgxlYsu6arXupjwOFgJDdrxZrivlpZWHZlB37ZiUMRHlzUnxrH0AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QibOJQnk; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QibOJQnk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc442c988b2so41653a12.0
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 06:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442137; cv=none;
        d=google.com; s=arc-20260327;
        b=MbJsQevOoIpfVoF7jOP34obtJbo+CP/6V8Oa65Du9GjRWKIErdbao5mjg5uDFoo0T3
         DFxat9An+HnVRW128tGSv+dgVodq8S3MKsua/oHZUIdooJ/ZmEIUtmdPWZgD2P9nDs4j
         pnizER6UIkuWVyBglHLHILEPP4utQ0UISkgM1blpk5uR+2B38aUwQ1S8iuE3i7Y1ywxs
         SdL6n37ddl6ag+tz29shFgOEnIMZsHyEhn5q2J9pJcJK8K73WO3+mYepBPiE9KaaVHLO
         p0PJQ0gIRsz+P3Qo3kEIWceHtsi3teddM5c/ovXWJzJ6WGWC7YPBdlJV9BGxtQs5MIm0
         879w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        fh=Ua1KGO4gA/COLpTW/0s7lEOtayydJlT2gqkR3Znd9kw=;
        b=dfnk4ZKaFMQCf9yHIJMOGvFnkKVpKYhe97XpB2toj1dVg8gYxfQ1+QDeNW9668VVir
         ko35fir59sb3l1upF0IzWXpX6RVpskkBQIt+7WFEjKey9H6aqskxmyYcY1fWMgGAeyEi
         somv/B/xXf1pz1+6OvtcQMPMCTeyeo2he8Z1YOrXZnByk9J8pjzv0nSS8to5mjI3jKpf
         848vOxK3xRfJh6j0sL7wU1YIdkQwYjVrSjMRhX8C56ELAsR9JHKC63OORUEKG3AlZmw0
         LJ065K6/f4/iwPpuFB1uE2vSsGTb4qc44cBdDt9+4Lm5DyP0eZ9D0c9dalw0JMKHXbj2
         ZljA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442137; x=1789046937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=QibOJQnk1IcJqAPts7niHKXB4MYd7rKKk/wudeEGKQp0iGQwDGwevv3JskZ75xdch6
         jfqm4L1dCpknWVRfoup0pgPVeoVkxrEgPBofP5UlvVojRvaPkpNXhQFo3YOpI5eUKzJ3
         oVIpCzNOrezqt2zVbyS0+jWle3e6IbhPsEo3ji4QqZhQGS8vqm75osJq5KNHbniSe7Cs
         7IMjXLKRAKNvoWjZP6f0QpU7q5nxhdS5rzzAAq7Cy/eRo92sBJSuU2C/89sY38/jJfVI
         jvANMBPDBxnLupAoA5f1OGYcmYjS1lAQ1aXvNLhVjMv0fKwt2U1nwuAN5oFlZ7SxOXAL
         4HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442137; x=1789046937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=XkJl3CH0pcUT0tITl4R3RsjM337gfKlo1OczVQUSXmDMCYlK4CEuvLd62kHVjNtFRN
         fla2cRcDGAZusJFaOCgjr7h5/KOJ4SKo4nhn4gwdKkfyUlafuKKI33Z9ud0t1O1Adw62
         3HPpUNypdMJPBQ7ZRnpIrYRXBhqaeu2XRDBTmHQdsavBX2JbqS/59WYZMQ+GhXfgbal9
         tCWBRUZvc/ZWw9JuHyUddSOAGrzAiffVBkOuoBTyOV1DCe2Ihauna/80q27PLfVefZXk
         uFHG2dvha2kffl56LFtr4SOz1Q4HlcDOPl0D7eJt2LYMLka9pvCUkdt9uscAsl5xyPig
         wiQg==
X-Forwarded-Encrypted: i=1; AKwUvBy9TvHPjsaGO8RXmXyifh3W0zXsveUBn5+QLcZ48HN7NFCc0Can5+tCOlEQM4lLajNx+S3OjG6We1HvJw==@vger.kernel.org
X-Gm-Message-State: AFuF++k5XoJ3WgmQY64dfboetQmMQMIcfxyepF+tMtOZGVNt85mfTFeh
	pPChWFqQd6bPTd6yb/riL3sTK1HJ18aDUkkrsfr9e8T4k2HEyG8Dmj28V6PvQ/OoeZ8bHpIa89P
	vT8RTDSWN9LwvhvKiBXtatNIJUQ1PaxE=
X-Gm-Gg: AYBFou2+e1pnoM7TDzXiBKsd4CL9whqwzxdimQpJ/TL+Njzl3vGjkEM2iTzrTLDgOHx
	kInFnH6Pc2yIVDq/HxRpKqh0RhAqK3KorLlQA9nTSKDsggNq3iPtL3Ys57z6lyErmuNnnRDpAzi
	TEvuSvJz1INh4HkNPFUNhTHKwrhXUws4rlD275EeJUWVFlun6AmGvxzOyC9KuLW72F0zeth56Xt
	TKloDqGt6hAYs5VzX2t7Z55vLqdj+VgfU+SCX1fN5Kzzu0iiYLDksMqo1nQvM/E435GXQGKRZxs
	zG95kndCXden59DFyKDyFITFBfIMjFh3B/aplt+S6RJO0tSF1mJjuldsMVaOU5tlu5AB06zVFsG
	fK4zeN4NKVzM9W/sz1wTPlTZOg9/vLVAOBwdV3vxtplzZVAN2Upa+ZfLF+fKX
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr12609481a91.3.1788442136905; Thu, 03 Sep 2026
 06:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org> <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
 <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 15:28:43 +0200
X-Gm-Features: AcwNN1XsmuEPyO39jqyvRGfAMw_DGGPMkiDRHtfg1ZEoNlBhpVDCHnmjvBP_pa8
Message-ID: <CANiq72muo8SotJHJQhEe=2kiprbrQTvrEMqd1Uw_7yNSfA3Gpw@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Do you want a link to this issue with a regular `Link:` tag?

Yeah, thanks!

Cheers,
Miguel
