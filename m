Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F34C04E69
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 19:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjHAT35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjHAT3z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2023 15:29:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2DF19AA
        for <linux-block@vger.kernel.org>; Tue,  1 Aug 2023 12:29:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9a2416b1cso4986209a34.2
        for <linux-block@vger.kernel.org>; Tue, 01 Aug 2023 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690918192; x=1691522992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VoATP9NhH/kSJB8+YTj7ST63aExW0zMTg/FlvDeldU=;
        b=SdoGE7ZGizDXbJRqNSzPFByd7neKDRG8vgDHG8wWrDk7Z7/KTjH2TS4QYzOvia6RNR
         jSo187iZ1Y0P8fLXtxglQLJKCFUv7Kxsuv/9iavDmMLeprd+m+/YvCjNymHL8zq+iQ0j
         DnKq58d2TsOX4iAzqQBRe8Hp1rZN6nyb9fpsoraZUicbFh9DHb/uzlKqyndedlb/nJRy
         Bo0lKCsI77WBEpBlgXAEOJOmejm2HoJwSS2B7jJejSgrYS+hiVbwBYzWxiMGmUorhK4r
         TSgxWS9DbAIJ9OnnXTRHeSKzq+qvZhxOUrB+K+5yVY2hS2EksqdgvxGeHATBviCI8YKY
         xNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690918192; x=1691522992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VoATP9NhH/kSJB8+YTj7ST63aExW0zMTg/FlvDeldU=;
        b=E10m7QTefYMXOkjddv+/rVHPq1y60GdWMdzQqoXoUw1ZWDwCH9LRpy30JCCTwgxjoA
         R7zrc3Br/bkW6cwUexSAQ3PVOmi/BEcSIGbVjRem16K16bzzQ1zk/Urc3xneCoCNfpZ0
         qDes2OiNxydbv5riwp4tNHQjcMY/Vbd0QO6JEUiUi1XeDp/ACNfqDVAozJocgjW6J8mj
         jbrrjL2VPBMybiMKL1orUjYM81bYOkFhb+S+e/CulNXg3214T5UZR4wSyqS9kElKl/GM
         H3f4dYD2vhV5w3VCZIySJdlL3RKAEboOZN/JnAEl7QcNt0ZkvMdpNyYsEbcxoUmR9yXC
         ZrbQ==
X-Gm-Message-State: ABy/qLaFnrgJlVfSwjid4vROR6D8JFvtH5bMWiPhd4x0QeEkwQoybPLm
        FuexaTSPyt78f5iFsvva39fhT842z+jMVhRyGwqc
X-Google-Smtp-Source: APBJJlFeosTdRRNCzhw56R7pSQbCNwevBbiNXiMElbuinfE7oB7aWtWCFN6s8eGVLK4C+bFbpQT0m3cUoqudXbEH1L0=
X-Received: by 2002:a05:6830:10e:b0:6b9:1af3:3307 with SMTP id
 i14-20020a056830010e00b006b91af33307mr13348963otp.17.1690918192119; Tue, 01
 Aug 2023 12:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <1687986571-16823-8-git-send-email-wufan@linux.microsoft.com>
 <fcc5de3f153eb60b5acf799c159e6ec8.paul@paul-moore.com> <20230715032644.GF15267@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230715032644.GF15267@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Aug 2023 15:29:40 -0400
Message-ID: <CAHC9VhQryLtJZ1W1ogyVuojnq0-ZAU-hfZLwpzUb=bobko9LsA@mail.gmail.com>
Subject: Re: [PATCH RFC v10 7/17] ipe: add userspace interface
To:     Fan Wu <wufan@linux.microsoft.com>
Cc:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 14, 2023 at 11:26=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com>=
 wrote:
> On Sat, Jul 08, 2023 at 12:23:04AM -0400, Paul Moore wrote:
> > On Jun 28, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> > >
> > > As is typical with LSMs, IPE uses securityfs as its interface with
> > > userspace. for a complete list of the interfaces and the respective
> > > inputs/outputs, please see the documentation under
> > > admin-guide/LSM/ipe.rst
> > >
> > > Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> > > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > > ---
> > >  security/ipe/Makefile    |   2 +
> > >  security/ipe/fs.c        | 101 ++++++++
> > >  security/ipe/fs.h        |  16 ++
> > >  security/ipe/ipe.c       |   3 +
> > >  security/ipe/ipe.h       |   2 +
> > >  security/ipe/policy.c    | 111 +++++++++
> > >  security/ipe/policy.h    |   9 +
> > >  security/ipe/policy_fs.c | 481 +++++++++++++++++++++++++++++++++++++=
++
> > >  8 files changed, 725 insertions(+)
> > >  create mode 100644 security/ipe/fs.c
> > >  create mode 100644 security/ipe/fs.h
> > >  create mode 100644 security/ipe/policy_fs.c

...

> > > @@ -39,6 +67,65 @@ static int set_pkcs7_data(void *ctx, const void *d=
ata, size_t len,
> > >     return 0;
> > >  }
> > >
> > > +/**
> > > + * ipe_update_policy - parse a new policy and replace @old with it.
> >
> > What does "@old" refer to?  I'm guessing you want to drop the "@".
> >
> Yes it shouldn't be here, sorry confusion.
>
> > > + * @root: Supplies a pointer to the securityfs inode saved the polic=
y.
> > > + * @text: Supplies a pointer to the plain text policy.
> > > + * @textlen: Supplies the length of @text.
> > > + * @pkcs7: Supplies a pointer to a buffer containing a pkcs7 message=
.
> > > + * @pkcs7len: Supplies the length of @pkcs7len.
> > > + *
> > > + * @text/@textlen is mutually exclusive with @pkcs7/@pkcs7len - see
> > > + * ipe_new_policy.
> > > + *
> > > + * Return:
> > > + * * !IS_ERR       - The old policy
> >
> > "The old policy" is what?
> >
> Let me try to pharse it in another way, how about the existing policy
> saved in the inode before update?

That sounds better, thanks.

> > > diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
> > > new file mode 100644
> > > index 000000000000..52a120118cda
> > > --- /dev/null
> > > +++ b/security/ipe/policy_fs.c
> > > @@ -0,0 +1,481 @@
> >
> > ...
> >
> > > +/**
> > > + * getactive - Read handler for "ipe/policies/$name/active".
> > > + * @f: Supplies a file structure representing the securityfs node.
> > > + * @data: Suppleis a buffer passed to the write syscall.
> > > + * @len: Supplies the length of @data.
> > > + * @offset: unused.
> > > + *
> > > + * @data will be populated with the 1 or 0 depending on if the
> > > + * corresponding policy is active.
> > > + *
> > > + * Return:
> > > + * * >0    - Success, Length of buffer written
> > > + * * <0    - Error
> > > + */
> > > +static ssize_t getactive(struct file *f, char __user *data,
> > > +                    size_t len, loff_t *offset)
> > > +{
> > > +   int rc =3D 0;
> > > +   const char *str;
> > > +   struct inode *root =3D NULL;
> > > +   const struct ipe_policy *p =3D NULL;
> > > +
> > > +   root =3D d_inode(f->f_path.dentry->d_parent);
> > > +
> > > +   inode_lock_shared(root);
> > > +   p =3D (struct ipe_policy *)root->i_private;
> > > +   if (!p) {
> > > +           inode_unlock_shared(root);
> > > +           return -ENOENT;
> > > +   }
> > > +   inode_unlock_shared(root);
> > > +
> > > +   str =3D (p =3D=3D rcu_access_pointer(ipe_active_policy)) ? "1" : =
"0";
> >
> > The line above should be wrapped with a RCU lock.
>
> This call only checks the value inside the pointer but doesn't dereferenc=
e it.
> Also from https://lwn.net/Articles/652156/ I found it says "The call to
> rcu_access_pointer() need not be protected. In contrast, rcu_dereference(=
) must
> either be within an RCU read-side critical section", so I didn't add the =
lock
> here, is this article outdated?

No, I believe you are correct.  There is always something new to learn
with RCU, thanks ;)

--=20
paul-moore.com
