Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] brd: Make rd_size argument static
To: Jan Kara <jack@suse.cz>
References: <1477396407-28847-1-git-send-email-jack@suse.cz>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <41412f23-2109-6de1-b742-d6a11be30167@kernel.dk>
Date: Tue, 25 Oct 2016 08:23:21 -0600
MIME-Version: 1.0
In-Reply-To: <1477396407-28847-1-git-send-email-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/2016 05:53 AM, Jan Kara wrote:
> rd_size does not appear to be used outside of brd. Make it static.

Applied both patches, thanks Jan.

-- 
Jens Axboe
