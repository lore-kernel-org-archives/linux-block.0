Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB9472063
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117801; cv=pass; b=nPfdZ4bbHdHm3SuytXg4FgoPQMqzOJhoJa1vLrA9K7mIGTKrvu4fjO1UH9OSM9mrk1ZlY4JYMde24Vx8jJpUg1KKqbs54rogvTxcPT2oLv8BAGDbH9S2CVOs+O4Z8U5JlRbsaICmSAHdigKFQ/MUzktWbawn+YWFmh9AMjk5xb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117801; c=relaxed/simple;
	bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpMCgxIEA4gdg/WMCX09KM8KvvO9Zmzt3KmJO1LtlaPDHL1p5xSqHW6xiZlHedmaSHNq7wRgLXX0EmA1H7DdunLetqCJiYI3HuKefwYwx2WolrebwqbwgEWJg7U3FDm0YDyY12Rrmxts/yDJr0f7BjWJyM6NGkOBzyuRpmF/nzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNGfych+; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNGfych+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-485888b3c3dso595547f8f.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 02:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117794; cv=none;
        d=google.com; s=arc-20260327;
        b=DHrH1jwoVEpATRKzV2GrOOEahEyY7cCG9kbvZ8kwkowldtOSn5Q7dp97AzwxnpiSMp
         2gxHpWgzSq8CrvcS17gUXw0DF5zQeQwz6mjpmVZGRNbTS1OyAbgFGYkO14lPUWAj43qu
         9z3segBCQOhlUsJnIUIDiCWdQcubGCiEHAk3fQT1S5KMzpkY9grkjL3Hqo+uBBnLeTW+
         ZTDva4LsLoHhlAztrp10ednxkvVDMKg18DqS60Go+eYokBzbO/yL13PK5CvIWMHb33Cw
         MiYCMk29wdD6q5ia/jrfjSYSpVkpKdUkGVGB8jEpN/zG1N7PQWsqYcpGq/vs71XB7y1G
         CFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        fh=MDXVFC0OkZHbxSQ0yLvenc2iKj/jZ1GZDEBWfOyq9Qo=;
        b=End2SMVwH5v/lDqJepqbPwHzgVHux8TjGArF25jehbeTDyMrpoBVkVGgRQ6/njswua
         xKkcD7hncvvuVhpS3NPkhHpcc6+QKjvF0PjcjJ8TQ1KotbpBoAnasBkBnnwdH+DMZDaE
         ByvcOrvkLJR1aqFVh5sgZi/VgHDsM2OgykGL0bAzZpGqqMoN44KdBmIudya9bShyiENg
         /tkE0lPRpJJ1YsgpWvsz4rcqHR+TJbO1ERXlq7vtjFJun/ajQC62syhd/z2dswF+3N/t
         oND2fc9jBm4TmE0eRS5fmmPUcmElZXlrWZc8sc6ibmSy+FXdxoyJD5T1kYV3Buynw6UP
         5IVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117794; x=1789722594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=eNGfych+G6ew1jh1huHnHXvI2jzl5xzK+HSAtpKSLWbZtctnZBu2UmqID47414dAOr
         cx+GEFp9K0+oennxk4sDJmqKuGbqewsDQc2MiXlv3XueKcIT4QUEsxHr3acPcqB4GIGI
         4HfDUpiKfZef2Ak8xHoYv2DUd/WA4jh9cyFbNEqYme427y/JRzTP53sdkcyitlue0+tg
         cSHI4NaOigA3QEw985dgxgJWsWSQQmnEy2RPoFxS7K41VrdkAK+TaHX+U7RqGWwUxC87
         IT2Y6dIHH1gJmnLcvMC18hEJZZtTgzCCCKBh2mFwW/AJ5GNUrlOSII9AGVrWORFUi5ob
         VCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117794; x=1789722594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=ShPKCXrV6R2xTKsjX0BD9ws2NfP3tmuZphH4G9hQJ/+q6zPIaXRpIkVE+jY/rIxyzb
         USeGNmqZZ+2DmWNHsiUWQlUobSHotk/tXtwdpk6gk5/hDu+QC5pk9HYyjAJ5q26Hfrv0
         fSzOPWHRh87PDSnZBjihqJsnMnmDhzbUkesMUKKAxHup9WufkkQKyzrMlFjwCHo2fMNS
         n5hcKBVyTIGDSjr/kZ9ptjdrri4+KEnVxa49VGXHvAm/5E3r0a7neVy9b/btghtTHkmW
         RWM4DTjeC4BfeEY4jtJSbVyrqZY0z0gHdSZi4O5+d8bzn3q44jeJEb6zOoIdSx38GKrH
         EiBA==
X-Forwarded-Encrypted: i=1; AKwUvBwUWi4RTK1UhbuwXyaiunSFE/9woFrJWqf6NmoTCtoX1vKaw6o9C9zpQuat3konJuB4+EFbfLNv+N2DSw==@vger.kernel.org
X-Gm-Message-State: AFuF++lqpVEMq7ylG+/AQVBRfEVbJI7d3SbAE0al1zAkU0t1lZcaaLBO
	g8MwKnj7jlTkPraHG+rLpf1CkTswUi9KjFc7tNv33QygE4nfUXD77pflKogYbbpqYPcwhx3/mp2
	wgjS+h4cOrkOuGR3X2RjdACs+r8j91xRpEd/eq/Ho
X-Gm-Gg: AYBFou28aOFNXfeuaiv9ugAddPU8Wpo5ZxL+Ec4zNkytE/71fHg+cxIf/kYfv7ym44y
	Skktae+YFJkdZJ4WAk3OC5U6MREluqSMN9fNdmOqiTWGEwvZCKtn5LqUdRxzXWtnmv+uMtB0uqs
	Y/2gkwIvswqzSwUREDs51un61wkHDQAXX7wA/iZ/zroHSnDaYRcGQwABp1h82aMeRKQ6lmzva9E
	EwlhYe75tmB6XWcW1smE4YCjnSztP5VIAk3rm9qu0JRdRmPIincd0fwYQRRHz3PSYR7sgr+xRln
	IBW4UNnrc7DTswrRmWHLlYefJ4nUE3KYwiPPqM7iWK2hZk8PlZtJYeMSeaTLB92zqcEmsp/wJvp
	6R+QvSfx8nSds4dPY9RAvCLsua1lzUP1XiLQT1mT+aQ3j2VNVhmQL
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-486eb2fe6e9mr2544735f8f.42.1789117791504; Fri, 11 Sep 2026
 02:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-5-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:09:37 +0200
X-Gm-Features: AcwNN1U8uQc4Zj212gVRashrRro-WErwh8uVMQ_MWKQsPaL29993fZfZR2Hn4U8
Message-ID: <CAH5fLggBGvXayMT2QGo5JeQkYeJYc0L-348-kKLsBs_g45-fnQ@mail.gmail.com>
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:02=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
