Return-Path: <dsterba@suse.cz>
Date: Thu, 24 May 2018 23:44:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V5 10/33] btrfs: use segment_last_page to get bio's last
 page
Message-ID: <20180524214441.GL6649@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20180524090139.2150-1-ming.lei@redhat.com>
 <20180524090139.2150-11-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524090139.2150-11-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 24, 2018 at 05:01:15PM +0800, Ming Lei wrote:
> Preparing for supporting multipage bvec.

Could you please also CC the cover letter so we have a chance to learn
what multipage bvec means or what are the changes between the
iterations? I found it in the archives, but a copy to mailinglist would
be good too. Thanks.
