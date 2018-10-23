Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728844AbeJWS15 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 14:27:57 -0400
Date: Tue, 23 Oct 2018 12:05:12 +0200
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/2] loop/006: Add test for setting partscan flag
Message-ID: <20181023100512.GA4695@quack2.suse.cz>
References: <20181018103147.3567-1-jack@suse.cz>
 <20181018103147.3567-2-jack@suse.cz>
 <20181022225255.GB10074@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181022225255.GB10074@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon 22-10-18 15:52:55, Omar Sandoval wrote:
> On Thu, Oct 18, 2018 at 12:31:46PM +0200, Jan Kara wrote:
> > Add test for setting partscan flag.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Sorry I didn't notice this earlier, but loop/001 already does a
> partition rescan (via losetup -P). Does that cover this test case?

Yes I know. But the partition rescanning on device creation has been
handled properly while partition rescanning as a result of LOOP_SET_STATUS
was buggy. That's why I've added this test.

> > +int main(int argc, char **argv)
> > +{
> > +	int ret;
> > +	int fd;
> > +	struct loop_info64 info;
> > +
> > +	if (argc != 2)
> > +		usage(argv[0]);
> > +
> > +	fd = open(argv[1], O_RDONLY);
> > +	if (fd == -1) {
> > +		perror("open");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	memset(&info, 0, sizeof(info));
> > +	info.lo_flags = LO_FLAGS_PARTSCAN;
> > +	memcpy(info.lo_file_name, "part", 5);
> 
> What's the significance of this file name?

Probably none, I guess I can just delete it. I think I've just copy-pasted
it from some other test excercising LOOP_SET_STATUS...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
