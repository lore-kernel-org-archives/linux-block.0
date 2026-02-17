Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9D3358B1
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330690; cv=none; b=bYGlxs5KeWa0dTjT85/WA8qRSMSMCOF4HuR5mAccVWqrf7iV7FHOD99cfloNkCfVI9BtISxLguhFindizhsE+7C0EyzPhV4fgXt3crcwNPBftl20qotbvco0gMvtPWwFS0kr5AnqYlUjBjNk6VAeKydAgSqCPVgIfoGXNueLhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330690; c=relaxed/simple;
	bh=8FaViZIsFFjduqimpKIDkioopbikGif5gxHaLIaZkTU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Lgy3SpPAKgCLfmnYHKS8nMDugxTA806sng+XOUgQ+HkhLayI9EvAaJcAj/xL8FkUYkQH2/Yv+kX5Ad3+at/4PnBKsTWji4f/gvdoY+Ovf9N708u7u+0rIKKrSsuWzHkmkWjbXXxpiXT1iDAfXFx8R+NAPunNJlIg7v0m1O5pjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da2TxgH+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da2TxgH+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so46467785e9.1
        for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 04:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771330688; x=1771935488; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTONtFoNtbkbeYo5PUcTqFHZpngRg049E98Be51k7a0=;
        b=Da2TxgH+1BQpdBJZ5xAHJXGDcdpQNPdHyEXoFBkOVDVZeYA9eYINi+tnm7IkIyw2io
         GX8uVWesRR5Mi1zYIgD7DlxvUmOZiuOnHPzcse/ftTTuf/zvY3+cPtNU56g+SpHa83ue
         7a5MD6tqVNgGgC4CyYH7PgEU99+sc+xJkdxQj3OSYB6pImqUE2VogXRd2WJgrwnplhSF
         984/ie11jHjeh//hJo3vu9Zauu99WttRnP6bcFfxKAWe2WJEiyoHUPNNDvKPlMgd/iqP
         Cr41TdVYNBnA6cXGL2kJ6tmT6l9Pi9Igq7E+OQmBPScKpSJXdwGsTOMSFKZ2v85BH+5J
         HwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771330688; x=1771935488;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTONtFoNtbkbeYo5PUcTqFHZpngRg049E98Be51k7a0=;
        b=IfpZanfRg9y8EyUauwStc4Lx6uuSyCyx8lphluWamlhkWW7NICdTqrkU7GkviOEKyO
         GEagNS7q9bRI8juXoDX1KUKfJ4sQy2zueF0SS0vIPFjDIYO7ptUsG1IdrwSsdYFDXvVc
         BWIFW1RnYcoZYpt1TjelUAd40r3fRM22Wl0JreUtK/29dpPSFvdNL+TqHqk+2e8YUrwp
         xyyLNG8lMPHyQuZ0YpqB+6t0oLcTxZ08ApUqWiRsCeZVj2+w4BZC8m9HZYsyRxra46pk
         Lb7yYDF77bNfvoOR9KHec2DsWxx0TUMHLMOOHxw1AplDaIfXGhPUVQn5FM98vu0EcOz0
         BYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHEdwbMh3oj3aIRRnqdwDTyxwLRq1I5zlfJJqeXYEddNhuqCmNSmAgnJxIP184Z2U5C7nLC2aX51CaGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LSzZ0gpmTKCgQdkfRk9biEGgbtAOJirRvDGJarIprQ94LQTA
	xY09FFcR3zuT3d5pF5AO1Z+gwheAeiF453MsyBVWnTQLmVIgbO+/ktKz
X-Gm-Gg: AZuq6aLLj2/YGDPATLh7+0UCu6fBGG5IfJ/PshF7T1qrY9ZNOmhF77HFX+vmXb8tsAZ
	uHtyLFsgwd3Mvnsn1611I7F4Zm9juuRUQVv9VZ6IBx3beur1OkeL1GCc23tU1oAupovlfDCcG+E
	mx+bAbRz24d8UAcj9knLhNNmGru0+dsO0/ypLFagy82YtCl9Uh5UX4bvwHvX/kNYjrdJG1dnQEk
	cznE5hKPjof71KlfdC5vmWQzAk3btG5IQ5vv3DDOm3j65JzXOZ84Rpnc0JGE+g8IA4bPOW5GzAc
	nE4P/DSGM+C1D4ee/0Wcqfz1wXZqFOmaVU7S04n+2kHUWUVqx6hh+1li3r+sN2dAA6HEtzanP0B
	d95JM/pk115tBL8fpJnq3bEW+T7knoie+kLWBb3XblmXE3gk6fKMV2reYjPc/OixYKyYiCHe7vP
	xSpLTeyNtwUIobKsBDw3HK6SK8R6VzDPhqHb+k/zB26PA0Lg==
X-Received: by 2002:a05:600c:6990:b0:483:8f38:a928 with SMTP id 5b1f17b1804b1-4838f38a961mr40324805e9.34.1771330687636;
        Tue, 17 Feb 2026 04:18:07 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7dc3:4609:42c2:f18f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d834ebesm525985725e9.13.2026.02.17.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 04:18:07 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hristo Venev <hristo@venev.name>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  Josef Bacik <josef@toxicpanda.com>,  Jens Axboe
 <axboe@kernel.dk>,  linux-block@vger.kernel.org,  nbd@other.debian.org
Subject: Re: [PATCH] netlink: specs: add specification for NBD
In-Reply-To: <20260215180309.2255721-3-hristo@venev.name>
Date: Tue, 17 Feb 2026 12:17:25 +0000
Message-ID: <m2o6lnlg2y.fsf@gmail.com>
References: <20260215180309.2255721-3-hristo@venev.name>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hristo Venev <hristo@venev.name> writes:

> This patch adds an initial YNL specification for NBD. The specification
> can be used to produce a UAPI header that is equivalent to the one
> currently shipped in the kernel.
>
> The spec appears to be accurate enough so that commands can be issued
> with pyynl.
>
> Signed-off-by: Hristo Venev <hristo@venev.name>
> ---
>  Documentation/netlink/specs/nbd.yaml | 206 +++++++++++++++++++++++++++
>  1 file changed, 206 insertions(+)
>  create mode 100644 Documentation/netlink/specs/nbd.yaml

There are yamllint errors:

make -C tools/net/ynl lint
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
yamllint ../../../Documentation/netlink/specs
../../../Documentation/netlink/specs/nbd.yaml
  159:81    error    line too long (104 > 80 characters)  (line-length)
  169:6     error    syntax error: expected <block end>, but found '<block mapping start>' (syntax)
  170:7     error    wrong indentation: expected 5 but found 6  (indentation)

>
> diff --git a/Documentation/netlink/specs/nbd.yaml b/Documentation/netlink/specs/nbd.yaml
> new file mode 100644
> index 0000000000000..a84912a867d91
> --- /dev/null
> +++ b/Documentation/netlink/specs/nbd.yaml
> @@ -0,0 +1,206 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +---
> +name: nbd
> +protocol: genetlink-c
> +uapi-header: linux/nbd-netlink.h
> +doc: See :file:`drivers/block/nbd.c`

Prefer to see a meaningful doc string here.

> +
> +c-family-name: nbd-genl-family-name
> +c-version-name: nbd-genl-version
> +max-by-define: true
> +
> +attribute-sets:
> +  -
> +    name: nbd-attrs
> +    name-prefix: nbd-attr-
> +    doc: Configuration policy attributes, used for CONNECT
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

No need for unspec in the attribute list, ynl codegen does the right thing.

> +      -
> +        name: index
> +        type: u32
> +      -
> +        name: size-bytes
> +        type: u64
> +      -
> +        name: block-size-bytes
> +        type: u64
> +      -
> +        name: timeout
> +        type: u64
> +      -
> +        name: server-flags
> +        type: u64
> +      -
> +        name: client-flags
> +        type: u64
> +      -
> +        name: sockets
> +        type: nest
> +        nested-attributes: sock-item-attrs
> +      -
> +        name: dead-conn-timeout
> +        type: u64
> +      -
> +        name: device-list
> +        type: nest
> +        nested-attributes: device-item-attrs
> +      -
> +        name: backend-identifier
> +        type: string
> +  -
> +    name: device-item-attrs
> +    name-prefix: nbd-device-item-
> +    doc: |
> +      This is the format for multiple devices with :code:`NBD_ATTR_DEVICE_LIST`
> +
> +      .. code-block::
> +
> +        [NBD_ATTR_DEVICE_LIST]
> +          [NBD_DEVICE_ITEM]
> +            [NBD_DEVICE_INDEX]
> +            [NBD_DEVICE_CONNECTED]
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: item
> +        name-prefix: nbd-device-
> +        type: nest
> +        nested-attributes: device-attrs
> +        multi-attr: true
> +  -
> +    name: device-attrs
> +    name-prefix: nbd-device-
> +    attr-max-name: nbd-device-attr-max
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: index
> +        type: u32
> +      -
> +        name: connected
> +        type: u8
> +  -
> +    name: sock-item-attrs
> +    name-prefix: nbd-sock-item-
> +    doc: |
> +      This is the format for multiple sockets with :code:`NBD_ATTR_SOCKETS`
> +
> +      .. code-block::
> +
> +        [NBD_ATTR_SOCKETS]
> +          [NBD_SOCK_ITEM]
> +            [NBD_SOCK_FD]
> +          [NBD_SOCK_ITEM]
> +            [NBD_SOCK_FD]
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: item
> +        name-prefix: nbd-sock-
> +        type: nest
> +        nested-attributes: sock-attrs
> +        multi-attr: true
> +  -
> +    name: sock-attrs
> +    name-prefix: nbd-sock-
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: fd
> +        type: u32
> +
> +operations:
> +  enum-model: unified
> +  name-prefix: nbd-cmd-
> +  list:
> +    -
> +      name: unspec
> +      value: 0
> +      doc: NBD_CMD_UNSPEC

Not required.

> +    -
> +      name: connect
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_connect()`

Prefer to see meaningful doc string (same for other ops)

> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]

nbd.c has strict & dump, should this be [strict, dump] ? (same for other ops)

> +      do:
> +        request:
> +          attributes:
> +            - index
> +            - size-bytes
> +            - block-size-bytes
> +            - timeout
> +            - server-flags
> +            - client-flags
> +            - sockets
> +            - dead-conn-timeout
> +            - backend-identifier
> +        reply:
> +          attributes:
> +            - index
> +    -
> +      name: disconnect
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_disconnect()`
> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]
> +      do:
> +        request:
> +          attributes:
> +            - index
> +    -
> +      name: reconfigure
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_reconfigure()`
> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]
> +      do:
> +        request:
> +          attributes:
> +            - index
> +            - size-bytes
> +            - block-size-bytes
> +            - timeout
> +            - client-flags
> +            - sockets
> +            - dead-conn-timeout
> +            - backend-identifier
> +    -
> +      name: link-dead
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_mark_nsock_dead()` / :code:`nbd_dead_link_work()`
> +      attribute-set: nbd-attrs
> +      event:
> +        attributes:
> +          - index
> +      mcgrp: nbd_mc_group
> +    -
> +      name: status
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_status()`
> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]
> +      do:
> +        request:
> +          attributes:
> +            - index
> +        reply:
> +          attributes:
> +            - device-list
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: nbd_mc_group
> +      c-define-name: nbd-genl-mcast-group-name
