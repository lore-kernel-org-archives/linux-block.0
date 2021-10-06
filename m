Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4B8C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 20:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5322161177
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 20:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhJFUyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhJFUyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 16:54:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7DCC061746;
        Wed,  6 Oct 2021 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=uUaggMIrJXJwK050Pd3Se7IpSEl1Adm3p+WvBJ2vdko=; b=jgTWnVUluiFhTPDmK08GSEh2kG
        XpbTv0VUuOw5KQi55TTUbo9Ax4g8VywNBW5WVzYdIDzLYwMjGLZtGThEjlbYdJuQ7AP0dSSWOWnDo
        8DV+HSdFgSAoxkUmB1lguBYBME75FUpFvhqjUwYCjMOlBH/u1jouPM9HxS1UedhdLTwOdOnYgR51t
        4mv0Z+mgjqz+hsMnqZX9H6bJpqOJHQOJAwe+K8MIDi3FkVX1Ga24geCz/lE+WsW2ThKjcL+a757es
        hP12tzuX8ndeNRgeFqIh7mgPNmXF2TPimJhyAk+scFa6bgS/YqO0Gw0g+U91/G8qWW64ZgmlOPV+Z
        5vkjUh0Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYDu8-00FWKD-Mu; Wed, 06 Oct 2021 20:52:44 +0000
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
To:     Lukas Prediger <lumip@lumip.de>, phil@philpotter.co.uk
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YT5BO7bUMMkwNCTh@equinox> <20210912191207.74449-1-lumip@lumip.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42492b83-8741-786d-1b6e-cdd122576ae3@infradead.org>
Date:   Wed, 6 Oct 2021 13:52:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912191207.74449-1-lumip@lumip.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/21 12:12 PM, Lukas Prediger wrote:
> diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> index 3b4c0506de46..bac5bbf93ca0 100644
> --- a/Documentation/userspace-api/ioctl/cdrom.rst
> +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> @@ -54,6 +54,9 @@ are as follows:
>   	CDROM_SELECT_SPEED	Set the CD-ROM speed
>   	CDROM_SELECT_DISC	Select disc (for juke-boxes)
>   	CDROM_MEDIA_CHANGED	Check is media changed
> +	CDROM_TIMED_MEDIA_CHANGE	Check if media changed
> +					since given time
> +					(struct cdrom_timed_media_change_info)
>   	CDROM_DRIVE_STATUS	Get tray position, etc.
>   	CDROM_DISC_STATUS	Get disc type, etc.
>   	CDROM_CHANGER_NSLOTS	Get number of slots

Hi Lukas, Phil,

This doc change causes a documentation build warning:

Documentation/userspace-api/ioctl/cdrom.rst:57: WARNING: Malformed table.
Text in column margin in table line 42.

The "=====" lines describe the table columns and they cannot be
exceeded without a warning. The table needs to be reformatted.

Lukas, will you handle that?
thanks.


======================  ===============================================
CDROMPAUSE              Pause Audio Operation
CDROMRESUME             Resume paused Audio Operation
CDROMPLAYMSF            Play Audio MSF (struct cdrom_msf)
CDROMPLAYTRKIND         Play Audio Track/index (struct cdrom_ti)
CDROMREADTOCHDR         Read TOC header (struct cdrom_tochdr)
CDROMREADTOCENTRY       Read TOC entry (struct cdrom_tocentry)
CDROMSTOP               Stop the cdrom drive
CDROMSTART              Start the cdrom drive
CDROMEJECT              Ejects the cdrom media
CDROMVOLCTRL            Control output volume (struct cdrom_volctrl)
CDROMSUBCHNL            Read subchannel data (struct cdrom_subchnl)
CDROMREADMODE2          Read CDROM mode 2 data (2336 Bytes)
                         (struct cdrom_read)
CDROMREADMODE1          Read CDROM mode 1 data (2048 Bytes)
                         (struct cdrom_read)
CDROMREADAUDIO          (struct cdrom_read_audio)
CDROMEJECT_SW           enable(1)/disable(0) auto-ejecting
CDROMMULTISESSION       Obtain the start-of-last-session
                         address of multi session disks
                         (struct cdrom_multisession)
CDROM_GET_MCN           Obtain the "Universal Product Code"
                         if available (struct cdrom_mcn)
CDROM_GET_UPC           Deprecated, use CDROM_GET_MCN instead.
CDROMRESET              hard-reset the drive
CDROMVOLREAD            Get the drive's volume setting
                         (struct cdrom_volctrl)
CDROMREADRAW            read data in raw mode (2352 Bytes)
                         (struct cdrom_read)
CDROMREADCOOKED         read data in cooked mode
CDROMSEEK               seek msf address
CDROMPLAYBLK            scsi-cd only, (struct cdrom_blk)
CDROMREADALL            read all 2646 bytes
CDROMGETSPINDOWN        return 4-bit spindown value
CDROMSETSPINDOWN        set 4-bit spindown value
CDROMCLOSETRAY          pendant of CDROMEJECT
CDROM_SET_OPTIONS       Set behavior options
CDROM_CLEAR_OPTIONS     Clear behavior options
CDROM_SELECT_SPEED      Set the CD-ROM speed
CDROM_SELECT_DISC       Select disc (for juke-boxes)
CDROM_MEDIA_CHANGED     Check is media changed
CDROM_TIMED_MEDIA_CHANGE        Check if media changed
                                 since given time
                                 (struct cdrom_timed_media_change_info)
CDROM_DRIVE_STATUS      Get tray position, etc.
CDROM_DISC_STATUS       Get disc type, etc.
CDROM_CHANGER_NSLOTS    Get number of slots
CDROM_LOCKDOOR          lock or unlock door
CDROM_DEBUG             Turn debug messages on/off
CDROM_GET_CAPABILITY    get capabilities
CDROMAUDIOBUFSIZ        set the audio buffer size
DVD_READ_STRUCT         Read structure
DVD_WRITE_STRUCT        Write structure
DVD_AUTH                Authentication
CDROM_SEND_PACKET       send a packet to the drive
CDROM_NEXT_WRITABLE     get next writable block
CDROM_LAST_WRITTEN      get last block written on disc
======================  ===============================================


-- 
~Randy
