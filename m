Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0F3A6B92
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790409399; cv=none; b=DKtk5NypoqEONx6OmFYCD9yuDjQaTDxfkgspR7w1ozpprKjdxfVSarrM35/mOdPjhN20LQj3kobSmuYhYRkOoep+xM7zKn4xQl6p1Brah3219/dj/pawldR6m9u6g66JVF75IuoHSy7i/7HcM+WmomhSB6Z2NPB3ByPFhzRn40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790409399; c=relaxed/simple;
	bh=yY5aPVN1kZdRX24f/rOo18N2WyJh702NUMPAilvlSUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAG5jFiGkez/G7tQxboECa5AN5W+FeAHLyLtAcLrmQRF5OTMMTu0SMEQad4T3j3zkTvreBcSD3oOekY0mFRmXRl5baHCE9SWEZFZoZkei6LzL6TIuhTgT086aiswFoDL6lFVDXNu730N+44W31lcKmIATNno0kIAkeiVGumi2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmiKvR24; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmiKvR24"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48882c1f261so419498f8f.0
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790409394; x=1791014194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YI9LML6UkRl05Tm2nCgeCpB6+5W0fxaRHeYbqDyeGfo=;
        b=mmiKvR24FbgMjygoeg6BB8jRgCPJkWtPtwrwqdGb7ukGfBXGooX1tM8Cxvka87E4Ft
         xI0fdGXhg0KAD0IfL3KIDWpM+cYK3kNr0arfep+z1tDNlL+Kr7G6ISQLpZk8dIaGA1YE
         dH97uGTKbS0UH+/Dfpg5EfoLhYKRk072eZjojnBB3KeYUJx3Yi4WFNTPdYKnc4okaN5L
         HQf2dWR3lIEogxRJi7BOJN/4go+24yCl49OccXKY68Jwbe7fEgNXXeLXhfu+eT9CQMG5
         3oPoBj8JL6cVvWmb0HsXtXUoL4AQd2bts16KJ7CL/ESeAkFGH3AKwd5AtErE/sbq9sDW
         KVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790409394; x=1791014194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YI9LML6UkRl05Tm2nCgeCpB6+5W0fxaRHeYbqDyeGfo=;
        b=mvMPkksj952sYIVkU/Lu6ZS3MU9kELhtC5G4kHCxjB8lsBg2GHoH+/uPDqnD64wgyk
         q24wyXPAS/thUnEVpvFL60Tf1ZvqtHisvb89rdf6W0x1FbTx5Rcx4WwLo/MBfzeCBT/c
         3ozgNu2txGQjJ/fyNfTr1X2zIWghbrJmj1YtXZaCfDyng7MsE0dTrc/X7nejeoggjDlV
         Qsjn0IFPQE0+JA9KAJ2+iDU2VKPdAAehVoqGi57qH9eqkzKMJ4BlINLmWgwTCd+7BQuk
         Y+92fl52U2TGmcNvefaSw2moVsFyC3VjiC360NrAAzhvMrG59VjShLkcZC8ExrIExxh4
         O0uA==
X-Forwarded-Encrypted: i=1; AKwUvBywxQTsfWdSKI7plm1Gb/UMP7lMg5gG1itasTga/T8O8vWkFhxlLUW9t4YKR0HWKsr69cy0Xgt4zI0+rA==@vger.kernel.org
X-Gm-Message-State: AFuF++lMIqa3b12yAWcSyc+mjRK9dLCAeS+fjxA0G4vXrRaC5ZlKpVti
	3Scsicdpw+HCz/2359DhURozRZLpJ3aqGfyfHRSxRY/eIiGW8TQmdZ12
X-Gm-Gg: AYBFou3nCxs9kAkB7lOhuDZiNWejnxmL9GNmYhDpMUfW24p9yS7j+cX1zmo5mSI3R2B
	eyn8RGCLdCw9VsgEHyelYVn8iWDTPk6ezkgtJiGeRoOIzZKNZIAhtpt17JPNoiWl8ecNnE7z9tx
	nPjrUkb8xovWoSYQiITWMUL65uBEbVRomBX3R8B6BjU+UQ1vE8b+NMg0gwKvnBTMJL5OVq6sKee
	r+Zre/O8JQUHKqZ/NgwxjkseP7OYvnisHCLuCJOx5R8sm792auq+tJ5xLFM0ujeBngJ3N/gb9hm
	ebBM+kczEXs/N5jef7f7mqgavWSbCK3aNM4ZJUvkNgqmNLQhprWOyeNYLn34TBIlDgWHoNPKlfI
	Uqxxb87qf2kKGKzT5aGp+hnBugEAYx/L4TzoYm4b2aJHLyQnE5ILYCANUn3Yaaf0lqxuhjJK1kd
	LYr04neOSJKZng3aHAtVST/oP+ePBBdqm6FArk/3fu+dv+JYfgajVZ3YwtonhFhKIUKuKs5qhRh
	sI9qYPGKZEdZ3AyYWq9Eqc=
X-Received: by 2002:a05:600c:8b82:b0:49f:fefc:7d01 with SMTP id 5b1f17b1804b1-49ffefc7e4dmr2208755e9.15.1790409394348;
        Sat, 26 Sep 2026 00:56:34 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe667ae2fsm204215155e9.13.2026.09.26.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:56:33 -0700 (PDT)
Date: Sat, 26 Sep 2026 09:56:28 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Cai Xinchen <caixinchen1@huawei.com>, mic@digikod.net,
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org,
	rdunlap@infradead.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dlemoal@kernel.org, hch@lst.de,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, dhowells@redhat.com, code@tyhicks.com,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, miklos@szeredi.hu, amir73il@gmail.com,
	senozhatsky@chromium.org, chenxiaosong@chenxiaosong.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com, omosnacek@gmail.com,
	casey@schaufler-ca.com, nanx95726@gmail.com, djwong@kernel.org,
	daniel@iogearbox.net, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	xiujianfeng@huawei.com, lujialin4@huawei.com
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
Message-ID: <20260926.255b951d3013@gnoack.org>
References: <20260924104831.1081137-1-caixinchen1@huawei.com>
 <araxO4ze0KZBz756@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <araxO4ze0KZBz756@suesslenovo>

Hello!

On Fri, Sep 25, 2026 at 02:03:05PM -0400, Justin Suess wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed in
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
> > 
> > Landlock evaluates access rights on a per-path basis, but the metadata
> > related LSM hooks (inode_getattr, inode_setattr, inode_setxattr,
> > inode_getxattr, inode_listxattr, inode_removexattr, inode_set_acl,
> > inode_get_acl, inode_remove_acl) only receive the dentry of the accessed
> > object.  Patches 1-7 therefore first pass struct path instead of dentry
> > through the metadata-related VFS helpers and LSM hooks.  This is a pure
> > refactoring with no behavior change, split so that every patch builds
> > and works on its own:
> >
> I like these patches, but is the ability to read metadata already
> sorta controlled by LANDLOCK_ACCESS_FS_READ_DIR on the parent
> directory?
> 
> The one case I see this being different is:
> 
> 1. if you wanted to grant read access to the file, but not metadata
> read access, but I can't think of any usecase for being able to read
> the contents of a file, but not the metadata. (see below)
> 
> 2. If you had the absolute path already and didn't need READ_DIR.
> 
> I see introducing this READ_METADATA as causing potential
> hard-to-diagnose issues.
> 
> Say you handle READ_METADATA and READ_FILE, but only grant READ_FILE.
> 
> The program can technically open the file with the READ_FILE permission,
> but it may error out because the stat() on it beforehand failed.
> It's pretty common for programs to do that kind of thing (stat before
> open), like for checking for config files (strace bash and you see it
> stat .profile, /etc/profile)
> 
> There may be other bugs, because being able to set permissions to read
> a file *but not read it's metadata* isn't possible currently in posix
> acl and userspace may not work well if that assumption no longer holds.
> 
> So maybe WRITE_METADATA is good enough?

The existing use cases are the combinations of (a) READ_DIR
allowed/denied and (b) READ_METADATA allowed/denied.  Because these
two access rights overlap slightly, it seems likely that for a given
directory or file, users will want to either grant both, or deny both.

At the moment, where the (not yet existing) READ_METADATA is
implicitly always allowed, the problematic case is the one where the
Landlock user wants to deny READ_DIR, but where much of the same
metadata is still available through stat() and the various
get-attribute syscalls.  (c.f. the warning box in the Landlock docs
[1])

In my view the READ_METADATA right closes a gap that READ_DIR left
open (which is also potentially surprising to callers if they did not
read the docs closely).  Also, if its implementation is symmetric to
WRITE_METADATA, I feel that it's worth having it in the same patch
set.

–Günther

P.S.: I know, even after we can control stat(), there are likely ways
to infer the presence of a file by observing Landlock error codes.
This would be nice to fix as well, but is harder to do without
controlling the path walk itself [2].  But also, the fact that this is
currently not controllable is not an excuse for leaving READ_METADATA
open IMHO.

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
[2] https://github.com/landlock-lsm/linux/issues/9
